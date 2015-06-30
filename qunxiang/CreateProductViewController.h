//
//  CreateProductViewController.h
//  qunxiang
//
//  Created by song jiekun on 15/6/3.
//  Copyright (c) 2015年 song jiekun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateProductViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>


@property (strong, nonatomic) NSArray *categoryArray;



@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *photo1Button;
@property (weak, nonatomic) IBOutlet UIButton *photo2Button;
@property (weak, nonatomic) IBOutlet UITextView *productDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *productPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *productCategoryTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *productCategoryPickerView;



- (IBAction)close:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)logout:(id)sender;

@end
