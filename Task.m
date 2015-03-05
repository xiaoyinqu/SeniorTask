//
//  Task.m
//  CSProject
//
//  Created by QuXiaoyin on 2/11/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "Task.h"

@implementation Task
-(instancetype)initWithTaskName:(NSString*)taskName sinceDate:(NSDate *)anotherDate andPriority:(NSInteger)priority{
    self.priorityLevel = priority;
    self.taskName = taskName;
    self.taskDate = anotherDate;
    self.isCompleted = [NSNumber numberWithBool:NO];
    return self;
    
}

-(void)updateTaskInformationWithTaskName:(NSString*)taskName sinceDate:(NSDate *)anotherDate andPriority:(NSInteger )priority andCompleteness: (NSNumber *)isComplete{
    self.priorityLevel = priority;
    self.taskName = taskName;
    self.taskDate = anotherDate;
    self.isCompleted = isComplete;
    
}
-(BOOL)ifTaskComplete{
    return self.isCompleted == [NSNumber numberWithBool:YES];
}


-(NSInteger) getTaskPriority{
    return self.priorityLevel;
}

@end
