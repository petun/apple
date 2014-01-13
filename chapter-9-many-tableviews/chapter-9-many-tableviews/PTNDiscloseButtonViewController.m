//
//  PTNDiscloseButtonViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDiscloseButtonViewController.h"
#import "PTNDiscloseDetailViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface PTNDiscloseButtonViewController ()

@end

@implementation PTNDiscloseButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.movies = @[@"Movie 1",@"Star track",@"Mash i medved"];
    
    self.detailController = [[PTNDiscloseDetailViewController alloc] init];
    self.detailController.title = @"Detail controller";
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
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.text = self.movies[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select row");
    
    NSString *message = self.movies[indexPath.row];
   
    self.detailController.message = message;
    
    [self.navigationController pushViewController:self.detailController animated:YES];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"title" message:@"message" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
    
    [alert show];
}

@end
