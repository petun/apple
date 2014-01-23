//
//  PTNDepartmentDetailViewController.m
//  vsw-with-storyboard
//
//  Created by petun on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDepartmentDetailViewController.h"
#import "PTNAppDelegate.h"
#import "PTNDetailPersonViewController.h"

@interface PTNDepartmentDetailViewController ()

@end

@implementation PTNDepartmentDetailViewController

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

-(void)setDepartmentNumber:(NSString *)departmentNumber {
    _departmentNumber = departmentNumber;
    
    // init self.departmentPersons
    PTNAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    NSPredicate *predicate =[NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject[@"ORGEH"] isEqualToString:_departmentNumber];
    }];
    
    
    
    NSArray *unsortedPersonal = [delegate.allPersons filteredArrayUsingPredicate:predicate];
    self.departmentPersonal = [unsortedPersonal sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *first = [obj1 objectForKey:@"FIO"];
        NSString *second = [obj2 objectForKey:@"FIO"];
        
        return [first compare:second];
    }];
}

-(void)setDepartmentName:(NSString *)departmentName {
    _departmentName = departmentName;
    self.title = _departmentName;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.departmentPersonal count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSDictionary *person = self.departmentPersonal[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", person[@"FIO"]];
    cell.detailTextLabel.text = person[@"PLANS_TXT"];
    
    cell.tag = indexPath.row;
    
    return cell;
}



#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PTNDetailPersonViewController *dest = segue.destinationViewController;
    UITableViewCell *cell = sender;
    dest.person = self.departmentPersonal[cell.tag];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
