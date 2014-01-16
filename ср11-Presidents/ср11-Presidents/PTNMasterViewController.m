//
//  PTNMasterViewController.m
//  ср11-Presidents
//
//  Created by petun on 15.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNMasterViewController.h"

#import "PTNDetailViewController.h"

@interface PTNMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation PTNMasterViewController

- (void)awakeFromNib
{
    // есил выделен какая то ячейка - не убирать выделение при изменеии ориентации планша
    self.clearsSelectionOnViewWillAppear = NO;
    // размер блока если данная view работает в режиме popover
    self.preferredContentSize = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    // каждый раз при выобре новой ячейки мы будет переиспользовать detail view controller
    self.detailViewController = (PTNDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // load presidents list
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PresidentList" ofType:@"plist"];
    NSDictionary *presidentsDict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.presidents = [presidentsDict objectForKey:@"presidents"];
    
    // Read settings for app
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *username = [defaults objectForKey:@"username"];
    NSLog(@"usernamr is %@",username);
    NSLog(@"password is %@",[defaults objectForKey:@"password"]);
    
    // END Read settings for app
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.presidents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDictionary *president = self.presidents[indexPath.row];
    cell.textLabel.text = president[@"name"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *president = self.presidents[indexPath.row];
    NSString *url = president[@"url"];
    self.detailViewController.detailItem = url;
}

@end
