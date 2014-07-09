//
//  DetailViewController.h
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSTableViewController.h"
#import "EditViewController.h"

@protocol DetailViewControllerDelegate <NSObject>

-(void)updateEmployee;

@end

@interface DetailViewController : UIViewController<EditViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *wageLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) id <DetailViewControllerDelegate> delegate;

@property (strong, nonatomic) RSEmployeeRecord *employeeRecord;

- (IBAction)EditEmp:(UIBarButtonItem *)sender;

@end
