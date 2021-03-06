//
//  ViewController.h
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSEmployeeRecord.h"

@protocol ViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddEmployee:(RSEmployeeRecord *)record;

@end

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *wageField;
@property (strong, nonatomic) IBOutlet UITextField *positionField;

@property (strong, nonatomic) RSEmployeeRecord *record;
@property (weak, nonatomic) id <ViewControllerDelegate> delegate;

- (IBAction)addEmployee:(UIBarButtonItem *)sender;
-(IBAction)cancelAdd:(UIButton *)sender;

@end


