//
//  PTNAdViewController.m
//  vksorg
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNAdViewController.h"
#import "PTNAdCell.h"
static NSString * const kCellAdId = @"kCellAdId";

@interface PTNAdViewController ()

@end

@implementation PTNAdViewController

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


    [self.tableView registerNib:[UINib nibWithNibName:@"PTNAdCell" bundle:nil] forCellReuseIdentifier:kCellAdId];
    
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

-(void)setCurrentSection:(NSDictionary *)currentSection {
    _currentSection = currentSection;
    
    // title
    self.title = _currentSection[@"name"];
    
    // load ads
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ads" ofType:@"plist"];
    self.ads = [[NSArray alloc] initWithContentsOfFile:path];
    
    
    
    
    NSLog(@"Found %i ads in section",[self.ads count]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ads count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTNAdCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellAdId];
    
    // Configure the cell...
    NSDictionary *ad = self.ads[indexPath.row];
    cell.ad = ad;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82;
}

@end
