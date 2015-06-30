//
//  MainViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/5.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "MainViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "LoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

//@synthesize placeholderView,productlistButton,categorylistButton,createButton,discusslistButton,profileButton,currentViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //展示第一个viewcontroller
    [self performSegueWithIdentifier:@"ShowProductList" sender:self.productlistButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSArray *segueIdentifierArray=@[@"ShowProductList",@"ShowCategoryList",@"ShowDiscussList",@"ShowProfile"];
    
    if ([segueIdentifierArray containsObject:segue.identifier]) {
        
        [self.productlistButton setSelected:NO];
        [self.categorylistButton setSelected:NO];
        [self.createButton setSelected:NO];
        [self.discusslistButton setSelected:NO];
        [self.profileButton setSelected:NO];
        
        UIButton *selectedButton=(UIButton *)sender;
        [selectedButton setSelected:YES];
        
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    
    //非注册用户无法submit product
    if ([identifier isEqualToString:@"SubmitProduct"]) {
        if ([AVUser currentUser]!=nil) {
            
            return YES;
            
        }
        else{
            
            
            UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //LoginViewController *loginViewController=[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            UINavigationController *loginNavigationController=[storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];


            [self presentViewController:loginNavigationController animated:YES completion:nil];
            
            return NO;
            
        }
    }
    
    return YES;
    
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
