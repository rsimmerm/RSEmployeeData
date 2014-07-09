//
//  EditViewController.h
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/9/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSEmployeeRecord.h"

@protocol EditViewControllerDelegate <NSObject>

-(void)didUpdateEmployee;

@end

@interface EditViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameField;
@property (strong, nonatomic) IBOutlet UITextField *wageField;
@property (strong, nonatomic) IBOutlet UITextField *positionField;

@property (strong, nonatomic) RSEmployeeRecord *record;
@property (weak, nonatomic) id <EditViewControllerDelegate> delegate;

- (IBAction)SaveEditedEmployee:(UIBarButtonItem *)sender;



@end
