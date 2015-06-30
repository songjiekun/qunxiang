//
//  LoginViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/13.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "LoginViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)weiboLogin:(id)sender {
    
    
    //用户通过微博登录
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"1054371572" andAppSecret:@"ab4f05bb3ba2f9b5e7c982c5f98b17d4" andRedirectURI:@"http://www.aituker.com"];
    
    /*
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        
        if (object && error==nil) {
            
            //与用户数据库绑定
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                
                
            }];
            
            
            
        }
        else {
            
            
            
            
        }
        
        
        
    } toPlatform:AVOSCloudSNSSinaWeibo];
    */
    
    //登录微博
    __weak LoginViewController *wSelf=self;
    UIViewController *sinaLoginVC=[AVOSCloudSNS loginManualyWithCallback:^(id object, NSError *error) {
        
        if (object && error==nil) {
            
            //与用户数据库绑定
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformWeiBo block:^(AVUser *user, NSError *error) {
                
                //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
                [wSelf.navigationController popViewControllerAnimated:YES];
                
            }];
            
            //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
            //[wSelf.navigationController popViewControllerAnimated:YES];


        }
        else {
            
            
            //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
            [wSelf.navigationController popViewControllerAnimated:YES];

            
        }
        
        
    } toPlatform:AVOSCloudSNSSinaWeibo];
    
    
    [self.navigationController pushViewController:sinaLoginVC animated:YES];
     
    
    
}

- (IBAction)qqLogin:(id)sender {
    
    //用户通过QQ登录
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSQQ withAppKey:@"" andAppSecret:@"" andRedirectURI:nil];
    
    
    //登录QQ
    __weak LoginViewController *wSelf=self;
    UIViewController *qqLoginVC=[AVOSCloudSNS loginManualyWithCallback:^(id object, NSError *error) {
        
        if (object && error==nil) {
            
            //与用户数据库绑定
            [AVUser loginWithAuthData:object platform:AVOSCloudSNSPlatformQQ block:^(AVUser *user, NSError *error) {
                
                //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
                [wSelf.navigationController popViewControllerAnimated:YES];
                
            }];
            
            //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
            //[wSelf.navigationController popViewControllerAnimated:YES];
            
            
        }
        else {
            
            
            //[sinaLoginVC dismissViewControllerAnimated:YES completion:nil];
            [wSelf.navigationController popViewControllerAnimated:YES];
            
            
        }
        
        
    } toPlatform:AVOSCloudSNSQQ];
    
    
    [self.navigationController pushViewController:qqLoginVC animated:YES];

    
}

- (IBAction)weixinLogin:(id)sender {
}

- (IBAction)close:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
