//
//  ViewController.m
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.wageField.delegate = self;
    self.positionField.delegate = self;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Optima" size:15],
      NSFontAttributeName, nil]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(RSEmployeeRecord *)returnNewEmployee
{
    RSEmployeeRecord *employeeObject = [[RSEmployeeRecord alloc] init];
    employeeObject.firstName = self.firstNameField.text;
    employeeObject.lastName = self.lastNameField.text;
    employeeObject.wage = [self.wageField.text intValue];
    employeeObject.position = self.positionField.text;
    
    return employeeObject;
}


#pragma mark - UITextFieldDelegate

/* Method is called when the user taps the return key. When this action occurs we tell the textField to dismiss the keyboard. */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)addEmployee:(UIBarButtonItem *)sender {
    [self.delegate didAddEmployee:[self returnNewEmployee]];
}


- (IBAction)cancelAdd:(UIButton *)sender {
    [self.delegate didCancel];
}
@end
