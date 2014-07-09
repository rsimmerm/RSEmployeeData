//
//  RSEmployeeRecord.m
//  RSEmployeeData
//
//  Created by Ross Simmerman on 7/7/14.
//  Copyright (c) 2014 RossSimmerman. All rights reserved.
//

#import "RSEmployeeRecord.h"

@implementation RSEmployeeRecord


/* Designated Initializer */
-(id)initWithData:(NSDictionary *)data
{
    /* Designated Initializer must call the super classes initialization method */
    self = [super init];
    
    /* Setup the object with values from the NSDictionary */
    if (self){
        self.firstName = data[EMPLOYEE_FIRST];
        self.lastName = data[EMPLOYEE_LAST];
        self.wage = [data[EMPLOYEE_WAGE]intValue];
        self.position = data[EMPLOYEE_POSITION];
    }
    
    return self;
}

/* Default initializer calls the new designated initializer initWithData */
-(id)init
{
    self = [self initWithData:nil];
    return self;
}
@end
