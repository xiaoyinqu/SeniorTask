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

@end
