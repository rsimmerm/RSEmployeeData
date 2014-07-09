//
//  RSTableViewController.h
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "DetailViewController.h"

#define EMPLOYEE_OBJECTS_KEY @"Employee Objects Key"


@interface RSTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, ViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *employeeObjects;


- (IBAction)addEmp:(UIBarButtonItem *)sender;
- (IBAction)reorderEmployees:(UIBarButtonItem *)sender;

@end







