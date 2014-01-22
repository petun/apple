//
//  PTNDetailPersonViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDetailPersonViewController.h"

@interface PTNDetailPersonViewController ()

@end

@implementation PTNDetailPersonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *name = [NSString stringWithFormat:@"%@ %@ %@", self.person[@"NACHN"],  self.person[@"VORNA"], self.person[@"MIDNM"]];
    self.title = name;
    
    self.personNameLabel.text = name;
    
    self.rankLabel.text = self.person[@"PLANS_TXT"];;
    
    
    self.departmentLabel.text = self.person[@"ORGEH_TXT"];
    self.orgLabel.text = self.person[@"BUKRSNAME"];
    
    self.telephoneLabel.text = self.person[@"TEL01"];
    self.emailLabel.text = self.person[@"MAIL"];
    self.mobTelLabel.text = self.person[@"MTELL"];
}

#pragma mark - Table view data source



@end
