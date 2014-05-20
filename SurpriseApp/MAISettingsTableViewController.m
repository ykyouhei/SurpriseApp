//
//  MAISettingsTableViewController.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/20.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAISettingsTableViewController.h"
#import "MAICardModelManager.h"

@interface MAISettingsTableViewController ()

@end

@implementation MAISettingsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [[[UIAlertView alloc] initWithTitle:nil
                                       message:@"メッセージを初期化しますか？"
                                      delegate:self
                             cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil] show];
            break;
        }
        default:
            break;
    }
}

- (IBAction)didTapCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[MAICardModelManager sharedManager].storedCards removeAllObjects];
        [MAICardModelManager sharedManager].enableTutorial = YES;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kMarryImageKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    [self.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES];
}


@end
