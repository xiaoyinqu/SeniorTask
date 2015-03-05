//
//  TaskListTableViewController.m
//  CSProject
//
//  Created by QuXiaoyin on 2/15/15.
//  Copyright (c) 2015 QuXiaoyin. All rights reserved.
//

#import "TaskListTableViewController.h"
#import "taskListTableViewCell.h"
#import <CoreData/CoreData.h>
#import "taskListTableViewCell.h"
#import <stdlib.h>

@interface TaskListTableViewController ()

@property (strong) NSMutableArray *tasks;


@end

@implementation TaskListTableViewController
@synthesize feedtableview = _feedtableview;

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void) reloadData
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Task"];
    
    [self.tasks removeAllObjects];
    self.tasks = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    self.feedtableview.delegate = self;
    self.feedtableview.dataSource = self;
    
    [self.feedtableview reloadData];

}


- (void) awakeFromNib {
    
    [super awakeFromNib];
    [self reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedtableview.backgroundColor = [UIColor colorWithWhite: 0.90 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (void) touchCellButton: (UIButton *)sender event:(id)event
{
    UIView *view = sender.superview;
    while (view != nil && ![view isKindOfClass:[taskListTableViewCell class]]) {
        view = [view superview];
    }
    taskListTableViewCell * taskCell = (taskListTableViewCell *) view;
    NSIndexPath *indexPath = [_feedtableview indexPathForCell:taskCell];
    
    NSManagedObject *task = [self.tasks objectAtIndex:indexPath.row/2];

    
    [task setValue: [NSNumber numberWithBool:YES] forKey:@"isComplete"];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }

    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ///This version worksfor databse but is not customized
    
    
    static NSString *CellIdentifier = @"taskcell";
    taskListTableViewCell *cell;
    
    if (indexPath.row % 2 == 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

        [cell.completebutton addTarget:self action:@selector(touchCellButton:event:) forControlEvents:UIControlEventTouchUpInside];
        // Configure the cell...
        
        
        NSManagedObject *task = [self.tasks objectAtIndex:indexPath.row/2];
        NSNumber * completionStatus = ( NSNumber * ) [task valueForKey:@"isComplete"];
        
        if ([completionStatus intValue] == [[NSNumber numberWithBool:NO] intValue]) {
            UIImage *buttonImage = [UIImage imageNamed:@"incomplete.png"];
            [cell.completebutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        } else {
            UIImage *buttonImage = [UIImage imageNamed:@"complete.png"];
            [cell.completebutton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        }
      
                
        // Show task name
        cell.contentLabel.text = [task valueForKey:@"taskName"];
        
        //Show due date in the right format
        NSDate *myDate = [task valueForKey:@"taskDueDate"];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d  hh:mm aa"];
        NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    
        cell.dueDateLabel.text = prettyVersion;

       
               return cell;
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"clearcell" forIndexPath:indexPath];

        [cell setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //    //This version doesn;t work for customized but it seems to be the must for customized table view
    //    static NSString *cellIdentifier = @"TaskTableCell";
    //    taskListTableViewCell *cell = (taskListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //    cell.nameLabel.text= @"just trying";
    //    /*cell.isComplete = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //    cell.isComplete.frame = CGRectMake(200.0f, 5.0f, 75.0f, 30.0f);
    //    [cell.isComplete setTitle:@"Complete" forState:UIControlStateNormal];
    //    [cell addSubview:cell.isComplete];
    //    [cell.isComplete addTarget:self
    //                        action:@selector(complete)
    //              forControlEvents:UIControlEventTouchUpInside];
    //     */
    
    return cell;
}

- (void)didTapButton:(UIButton *)button{

    [button setBackgroundImage:[UIImage imageNamed:@"ok-104.png"] forState:UIControlStateNormal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1)
        return 40;
    return 162;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // two times minus one (invisible at even rows => visibleCount == invisibleCount+1)
    return [self.tasks count] * 2 - 1;
}

-(void)complete{
    NSLog(@"Completed the task");
}
//- (taskListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NdxSIndexPath *)indexPath {
//taskListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];

// Configure the cell...

//return cell;
//return NULL;
//}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
