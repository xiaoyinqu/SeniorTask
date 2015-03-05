//
//  taskListTableViewCell.h
//  CSProject
//
//  Created by QuXiaoyin on 2/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taskListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@property (weak, nonatomic) IBOutlet UILabel *completeLabel;
@property (weak, nonatomic) IBOutlet UIButton *completebutton;

@end
