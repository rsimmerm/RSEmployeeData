//
//  EditViewController.m
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/9/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

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

-(void)updateEmployee
{
    self.record.firstName = self.firstNameField.text;
    self.record.lastName = self.lastNameField.text;
    self.record.wage = [self.wageField.text intValue];
    self.record.position = self.positionField.text;
}
 

#pragma mark - EditViewControllerDelegate

/* Method is called when the user taps the return key. When this action occurs we tell the textField to dismiss the keyboard. */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)SaveEditedEmployee:(UIBarButtonItem *)sender
{
    [self updateEmployee];
    [self.delegate didUpdateEmployee];
}


@end
