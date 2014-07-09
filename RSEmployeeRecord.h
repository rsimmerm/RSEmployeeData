//
//  RSEmployeeRecord.h
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EMPLOYEE_FIRST @"FIRST_NAME"
#define EMPLOYEE_LAST @"LAST_NAME"
#define EMPLOYEE_WAGE @"WAGE"
#define EMPLOYEE_POSITION @"POSITION"

@interface RSEmployeeRecord : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (nonatomic) int wage;
@property (strong, nonatomic) NSString *position;

/* Custom Initializer which has a single parameter of class NSDictionary. */
-(id)initWithData:(NSDictionary *)data;


@end
