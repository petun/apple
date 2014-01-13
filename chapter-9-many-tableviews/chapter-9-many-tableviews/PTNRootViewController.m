//
//  PTNRootViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNRootViewController.h"
#import "PTNSecondViewController.h"
#import "PTNDiscloseButtonViewController.h"
#import "PTNCheckViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface PTNRootViewController ()

@end

@implementation PTNRootViewController

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
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.title = @"Root controller";
 
    
    PTNDiscloseButtonViewController *discl = [[PTNDiscloseButtonViewController alloc] init];
    discl.title = @"Disclosure controller";
    
    PTNCheckViewController *checkController = [[PTNCheckViewController alloc] init];
    
    self.controllers = @[discl,checkController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    PTNSecondViewController *s = self.controllers[indexPath.row];
    cell.textLabel.text = s.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTNSecondViewController *sController = self.controllers[indexPath.row];
    [self.navigationController pushViewController:sController animated:YES];
}



@end
