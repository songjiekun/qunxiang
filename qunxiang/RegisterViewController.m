//
//  RegisterViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/14.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "RegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

//@synthesize userNameTextField,passwordTextField,telephoneTextField,codeTextField,errorLabel;

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

#pragma mark - 用户注册
- (IBAction)registerUser:(id)sender {
    
    NSString *username=self.userNameTextField.text;
    NSString *password=self.passwordTextField.text;
    NSString *telephone=self.telephoneTextField.text;
    NSString *verfiedCode=self.codeTextField.text;
    
    //手机验证码确认
    [AVOSCloud verifySmsCode:verfiedCode mobilePhoneNumber:telephone callback:^(BOOL succeeded, NSError *error) {
        
        if(succeeded){
            
            self.errorLabel.text=@"验证成功";
            
            AVUser *user=[AVUser user];
            user.username=username;
            user.password=password;
            user.mobilePhoneNumber=telephone;
            
            //注册用户-注册成功的用户直接已经登录
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    self.errorLabel.text=@"注册成功";
                    
                }
                else{
                    
                    self.errorLabel.text=@"注册失败";
                    
                }
                
            }];
            
        }
        else{
            
            self.errorLabel.text=@"验证失败";
            
        }
        
        
    }];
    
    
    
    
    
}


#pragma mark - 请求短信验证码
- (IBAction)sendCode:(id)sender {
    
    NSString *telephone=self.telephoneTextField.text;
    
    [AVOSCloud requestSmsCodeWithPhoneNumber:telephone callback:^(BOOL succeeded, NSError *error) {
        
        if(succeeded){
            
            self.errorLabel.text=@"发送成功";
            
        }
        else{
           
            self.errorLabel.text=@"发送失败";
            
        }
        
        
    }];
    
}
@end
