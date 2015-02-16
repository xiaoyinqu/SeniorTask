//
//  taskListTableViewCell.h
//  CSProject
//
//  Created by QuXiaoyin on 2/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taskListTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;
@property (nonatomic, weak) IBOutlet UIButton *isCompleteButton;
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@end
