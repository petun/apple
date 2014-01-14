//
//  PTNStaticCellsViewController.m
//  ch10-Simple Storyboar App
//
//  Created by petun on 15.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNStaticCellsViewController.h"

@interface PTNStaticCellsViewController ()

@end

@implementation PTNStaticCellsViewController

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
    
    NSDate *now = [NSDate new];
    self.dateLabel.text = [NSDateFormatter
                           localizedStringFromDate:now
                           dateStyle:NSDateFormatterLongStyle
                           timeStyle:NSDateFormatterNoStyle];
    
    self.timeLabel.text = [NSDateFormatter
                           localizedStringFromDate:now
                           dateStyle:NSDateFormatterNoStyle
                           timeStyle:NSDateFormatterLongStyle];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
