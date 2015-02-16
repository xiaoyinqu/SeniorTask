//
//  Task.h
//  CSProject
//
//  Created by QuXiaoyin on 2/11/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject
@property (nonatomic) NSInteger priorityLevel;
@property (strong, nonatomic) NSString* taskName;
@property (strong, nonatomic) NSDate* taskDate;
@property BOOL isCompleted;
-(instancetype)initWithTaskName:(NSString*)taskName sinceDate:(NSDate *)anotherDate andPriority:(NSInteger)priority;
-(void)updateTaskInformationWithTaskName:(NSString*)taskName sinceDate:(NSDate *)anotherDate andPriority:(NSInteger )priority andCompleteness: (BOOL)isComplete;
-(BOOL)ifTaskComplete;
-(NSInteger) getTaskPriority;

@end

