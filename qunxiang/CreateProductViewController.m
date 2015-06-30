//
//  CreateProductViewController.m
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import "CreateProductViewController.h"
#import "ProductMore.h"
#import <QuartzCore/QuartzCore.h>
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>


@interface CreateProductViewController ()

@end

@implementation CreateProductViewController

//@synthesize categoryArray,productCategoryPickerView,productCategoryTextField,productDescriptionTextView,productPriceTextField,closeButton,submitButton,photo1Button,photo2Button;

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if((self=[super initWithCoder:aDecoder])){
        
        //初始化categoryarray
        self.categoryArray= @[@"类型1",@"类型2",@"类型3",@"类型4",@"类型5",@"类型6",@"类型7"];
        
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    //UIPickerView *productCategoryPickerView = [[UIPickerView alloc] init];
    //productCategoryPickerView.showsSelectionIndicator=YES;
    //productCategoryPickerView.dataSource=self;
    //productCategoryPickerView.delegate=self;
    
    //为category输入框 添加pickerview
    [self.productCategoryPickerView removeFromSuperview];
    self.productCategoryTextField.inputView=self.productCategoryPickerView;
    
    //为description输入框 添加边框 需要导入<QuartzCore/QuartzCore.h>
    self.productDescriptionTextView.layer.borderWidth=2.0;
    self.productDescriptionTextView.layer.borderColor=[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
    self.productDescriptionTextView.layer.cornerRadius=5;
    self.productDescriptionTextView.clipsToBounds=YES;
    
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



#pragma mark - TextField代理
//可以被强制输入中文 不知为何。
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
}

#pragma mark - pickerview 数据协议
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.categoryArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.categoryArray[row];
}


#pragma mark - pickerview 代理

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.productCategoryTextField.text=self.categoryArray[row];
}



#pragma mark - 关闭view

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 发送图片

- (IBAction)submit:(id)sender {
    
    NSString *description=self.productDescriptionTextView.text;
    NSNumber *price=@([self.productPriceTextField.text integerValue]);
    NSString *category=self.productCategoryTextField.text;
    ProductMore *newProduct = [ProductMore productOfDescription:description category:category price:price  url:nil createdDate:nil updatedDate:nil context:nil];
    
    [newProduct submitProduct:self.photo1Button.currentBackgroundImage];
    
    
}

- (IBAction)logout:(id)sender {
    
    [AVUser logOut];
    [AVOSCloudSNS logout:AVOSCloudSNSSinaWeibo];
    
    
}

#pragma mark - 拍照

- (IBAction)takePhoto:(id)sender {
    
    if ([UIAlertController class])
    {
        // use UIAlertController
        UIAlertController *actionSheet= [UIAlertController
                                   alertControllerWithTitle:@"图片"
                                   message:@"选择来源"
                                   preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       //Do Some action here
                                                       
                                                       
                                                       //确定可以访问照片集
                                                       if (([UIImagePickerController isSourceTypeAvailable:
                                                             UIImagePickerControllerSourceTypePhotoLibrary] == NO)
)
                                                           return;
                                                       
                                                       UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
                                                       
                                                       imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                                                       //imagePickerController.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
                                                       imagePickerController.allowsEditing=NO;
                                                       imagePickerController.delegate=self;
                                                       [self presentViewController:imagePickerController animated:YES completion:nil];
                                                       
                                                       
                                                       
                                                   }];
        UIAlertAction* camera = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                              
                                                           //确定可以相机
                                                           if (([UIImagePickerController isSourceTypeAvailable:
                                                                 UIImagePickerControllerSourceTypeCamera] == NO)
                                                               )
                                                               return;
                                                           
                                                           UIImagePickerController *cameraController=[[UIImagePickerController alloc] init];
                                                           
                                                           cameraController.sourceType=UIImagePickerControllerSourceTypeCamera;
                                                           //imagePickerController.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
                                                           cameraController.allowsEditing=NO;
                                                           cameraController.delegate=self;
                                                           [self presentViewController:cameraController animated:YES completion:nil];
                                                           
                                                       }];
        
        UIAlertAction* cancel= [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           [actionSheet dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
        
        [actionSheet addAction:album];
        [actionSheet addAction:camera];
        [actionSheet addAction:cancel];
        
        
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }
    else
    {
        
        UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"分享图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机",nil];
        
        [actionSheet showInView:self.view];

        
        
    }
}


#pragma mark - actionsheet 代理
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        
        
    }
    else if (buttonIndex==1) {
        
        
    }

    
    
}

#pragma mark - imagePicker 代理
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        
        UIImage *pickedImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.photo1Button setBackgroundImage:pickedImage forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    else{
        
        UIImage *pickedImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        //拍的照片存入相册中
        UIImageWriteToSavedPhotosAlbum (pickedImage, nil, nil , nil);
        [self.photo1Button setBackgroundImage:pickedImage forState:UIControlStateNormal];
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end
