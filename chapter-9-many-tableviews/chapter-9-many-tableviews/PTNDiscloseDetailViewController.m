//
//  PTNDiscloseDetailViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDiscloseDetailViewController.h"

@interface PTNDiscloseDetailViewController ()

@end

@implementation PTNDiscloseDetailViewController




-(UILabel *)label;
{
    return (id)self.view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines =0;
    label.textAlignment = NSTextAlignmentCenter;
    self.view = label;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.label.text = self.message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
