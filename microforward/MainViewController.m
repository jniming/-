//
//  MainViewController.m
//  microforward
//
//  Created by 张小明 on 2017/8/1.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "MainViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "JsObject.h"



#import <JavaScriptCore/JavaScriptCore.h>
#import <Masonry.h>

#import "MobManager.h"

#import "Constans.h"

#define Scr_height ([UIScreen mainScreen].bounds.size.height)
#define Scr_width ([UIScreen mainScreen].bounds.size.width)
@interface MainViewController ()
@property UIWebView *webView;
@property MobManager *mobmanager;

@property UIView *mbView;

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    [right setTintColor:[UIColor blackColor]];
    
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    [left setTintColor:[UIColor blackColor]];
    //这里直接用self.navigationItem 不要用 self.navigationController.navigationItem
   
      [self.navigationItem setLeftBarButtonItem:left];
    [self.navigationItem setRightBarButtonItem:right];
   
   
}




-(void)rightAction{
    
//    [self.webView reload];
    

//    [self.navigationItem setLeftBarButtonItem:nil];
}
-(void)leftAction{
    [self.webView goBack];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.title=@"微赚头条";
    self.webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, Scr_width, Scr_height)];
    self.webView.delegate=self;
    
    [self.view addSubview:self.webView];
    
    NSURL *ur=[NSURL URLWithString:mainUrl];
    
    //网页自适应屏幕
    self.webView.scalesPageToFit=YES;
    
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
//    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"main"
//                                                          ofType:@"html"];
//    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
//                                                    encoding:NSUTF8StringEncoding
//                                                       error:nil];
//    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    
   
    
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:ur]];
    
    
    
    _mobmanager=[[MobManager alloc]init];
    
    
    
    //通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sharp:) name:@"sharp" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendCode:) name:@"sendcode" object:nil];
    
    
    [self createMbView];
}

//发送验证码
-(void)sendCode:(NSNotification *)not{
    NSDictionary *dir=not.object;
    NSString *ccode=dir[@"ccode"];
    NSString *phone=dir[@"phone"];
    [_mobmanager sendSMScode:ccode phone:phone];
    
    

}


//分享
-(void)sharp:(NSNotification *)not{

    [self.mobmanager sharp:not.object view:self.view];
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *currentURL= request.URL.absoluteString;
    
    BOOL list_st= [currentURL containsString:@"list.do"];
    BOOL app_st= [currentURL containsString:@"apprent.do"];
    BOOL cen_st= [currentURL containsString:@"ucenter.do"];
    BOOL login_st= [currentURL containsString:@"login.do"];
          BOOL index_st= [currentURL containsString:@"index.do"];
    if(list_st||app_st||cen_st||login_st||index_st){
        self.navigationItem.leftBarButtonItem=nil;
        
    }else{
        UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithTitle:@"上一页" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
        [left setTintColor:[UIColor blackColor]];
        //这里直接用self.navigationItem 不要用 self.navigationController.navigationItem
        
        [self.navigationItem setLeftBarButtonItem:left];
    }
    
    
   
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
  

     [self.mbView setHidden:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    
    
    
  }



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"webViewDidFinishLoad");
   
  
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
  
//    [self.mb hideAnimated:YES];
    
    
     //页面加载完成方可调用
      [self jsAction];
}




//js调用oc方法,这是js通过注入的对象调用oc方法,
-(void)jsAction{
    //创建JSContext对象，（此处通过当前webView的键获取到jscontext）
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JsObject *obj=[[JsObject alloc]init];
    //ApObject是js注入的对象
    context[@"apobject"] = obj;    //将对象注入JS运行环境
   
}

-(void)viewDidAppear:(BOOL)animated{

//    //移除所有通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
         NSLog(@"didFailLoadWithError");
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self.mbView setHidden:NO];
    
  
}

-(void)createMbView{
    _mbView=[[UIView alloc]init];
    _mbView.backgroundColor=[UIColor whiteColor];
    
    UILabel *text=[[UILabel alloc]init];
    text.text=@"数据加载出错,请点击刷新重试!";
    text.font=[UIFont systemFontOfSize:14];
    
    UIImageView *imgview=[[UIImageView alloc]init];
    imgview.image=[UIImage imageNamed:@"icon_nosp"];
    imgview.contentMode=UIViewContentModeScaleAspectFit;
    
    
    [self.view addSubview:_mbView];
    [_mbView addSubview:text];
     [_mbView addSubview:imgview];
    
    [self.mbView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.view);
          make.left.equalTo(self.view);
         make.top.equalTo(self.view);
          make.bottom.equalTo(self.view);
    }];
    
   
    
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-20);
        
        
     
        
        make.size.mas_equalTo(CGSizeMake(150, 100));
    }];
    
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imgview.mas_bottom).offset(20);
    }];
    
    [self.mbView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end



