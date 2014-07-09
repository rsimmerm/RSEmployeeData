//
//  DetailViewController.m
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.firstNameLabel.text = [NSString stringWithFormat:@"First Name: %@",self.employeeRecord.firstName];
    self.lastNameLabel.text = [NSString stringWithFormat:@"Last Name: %@",self.employeeRecord.lastName];
    self.wageLabel.text = [NSString stringWithFormat:@"Wage: $%i/hr", self.employeeRecord.wage];
    self.positionLabel.text = [NSString stringWithFormat:@"Position: %@",self.employeeRecord.position];
    
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

- (IBAction)EditEmp:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEdit" sender:sender];
}

-(void)didUpdateEmployee
{
    self.firstNameLabel.text = self.employeeRecord.firstName;
    self.lastNameLabel.text = self.employeeRecord.lastName;
    self.wageLabel.text = [NSString stringWithFormat:@"%i/hr", self.employeeRecord.wage];
    self.positionLabel.text = self.employeeRecord.position;
    /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"yyyy-MM-dd"];
     NSString *stringFromDate = [formatter stringFromDate:self.goal.date];
     self.dateLabel.text = stringFromDate;*/
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateEmployee];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[EditViewController class]]){
        EditViewController *editViewController = segue.destinationViewController;
        editViewController.record = self.employeeRecord;
        editViewController.delegate = self;
    }
}

@end
