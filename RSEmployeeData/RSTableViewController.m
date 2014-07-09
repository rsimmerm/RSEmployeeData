//
//  RSTableViewController.m
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import "RSTableViewController.h"

@interface RSTableViewController ()

@end

@implementation RSTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSMutableArray *)employeeObjects
{
    if (!_employeeObjects){
        _employeeObjects = [[NSMutableArray alloc] init];
    }
    
    return _employeeObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSArray *employeesAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:EMPLOYEE_OBJECTS_KEY];
    
    for (NSDictionary *dictionary in employeesAsPropertyLists){
        RSEmployeeRecord *employeeRecord = [self employeeObjectForDictionary:dictionary];
        [self.employeeObjects addObject:employeeRecord];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Optima" size:15],
      NSFontAttributeName, nil]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didAddEmployee:(RSEmployeeRecord *)record
{
    /*  Add the task object to the taskObjects array. */
    [self.employeeObjects addObject:record];
    
    /* Use NSUserDefaults to access all previously saved tasks. If there were not saved tasks we allocate and initialize the NSMutableArray named taskObjectsAsPropertyLists. */
    NSMutableArray *empObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:EMPLOYEE_OBJECTS_KEY] mutableCopy];
    if (!empObjectsAsPropertyLists) empObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    /* First convert the task object to a property list using the method taskObjectAsAPropertyList. Then add the propertylist (dictionary) to the taskObjectsAsPropertyLists NSMutableArray. Synchronize will save the added array to NSUserDefaults.*/
    [empObjectsAsPropertyLists addObject:[self employeeObjectsDict:record]];
    [[NSUserDefaults standardUserDefaults] setObject:empObjectsAsPropertyLists forKey:EMPLOYEE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    /* Dismiss the AddTaskViewController as the presented view and reload the tableView with the added task */
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSDictionary *)employeeObjectsDict:(RSEmployeeRecord *)empRecord
{
    NSDictionary *dictionary = @{EMPLOYEE_FIRST: empRecord.firstName, EMPLOYEE_LAST : empRecord.lastName, EMPLOYEE_WAGE : @(empRecord.wage), EMPLOYEE_POSITION : empRecord.position };
    return dictionary;
}

-(RSEmployeeRecord *)employeeObjectForDictionary:(NSDictionary *)dictionary
{
    RSEmployeeRecord *employeeObject = [[RSEmployeeRecord alloc] initWithData:dictionary];
    return employeeObject;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.employeeObjects count];
}

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 EmployeeRecord *record = self.employeeObjects[indexPath.row];
 [self updateCompletionOfGoal:record forIndexPath:indexPath];
 }*/

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetail" sender:indexPath];
}

-(void)saveEmployees
{
    /* Create a NSMutableArray that we will NSDictionaries returned from the method taskObjectAsAPropertyList. */
    NSMutableArray *empObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.employeeObjects count]; x ++){
        [empObjectsAsPropertyLists addObject:[self employeeObjectsDict:self.employeeObjects[x]]];
    }
    
    /* Save the updated array to NSUserDefaults. */
    [[NSUserDefaults standardUserDefaults] setObject:empObjectsAsPropertyLists forKey:EMPLOYEE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    RSEmployeeRecord *record = self.employeeObjects[indexPath.row];
    cell.textLabel.text = record.firstName;
    cell.detailTextLabel.text = record.lastName;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        /* If a user deletes the row remove the task at that row from the tasksArray */
        [self.employeeObjects removeObjectAtIndex:indexPath.row];
        
        /* With the updated array of task objects iterate over them and convert them to plists. Save the plists in the newTaskObjectsData NSMutableArray. Save this array to NSUserDefaults. */
        NSMutableArray *newEmployeeObjectsData = [[NSMutableArray alloc] init];
        
        for (RSEmployeeRecord *record in self.employeeObjects){
            [newEmployeeObjectsData addObject:[self employeeObjectsDict:record]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newEmployeeObjectsData forKey:EMPLOYEE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        /* Animate the deletion of the cell */
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    RSEmployeeRecord *employeeObject = self.employeeObjects[fromIndexPath.row];
    [self.employeeObjects removeObjectAtIndex:fromIndexPath.row];
    [self.employeeObjects insertObject:employeeObject atIndex:toIndexPath.row];
    [self saveEmployees];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(void)reorderCells
{
    if (self.tableView.editing == YES)[self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
}

#pragma mark - Navigation


- (IBAction)addEmp:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddEmployee" sender:sender];
}


- (IBAction)reorderEmployees:(UIBarButtonItem *)sender
{
    [self reorderCells];
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[ViewController class]]){
        ViewController *addGoalViewController = segue.destinationViewController;
        addGoalViewController.delegate = self;
    }
    
    else if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]){
        DetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *path = sender;
        RSEmployeeRecord *empObject = self.employeeObjects[path.row];
        detailViewController.employeeRecord = empObject;
        //detailViewController.delegate = self;
    }
}


@end
