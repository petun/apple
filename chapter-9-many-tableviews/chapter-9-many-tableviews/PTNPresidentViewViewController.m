//
//  PTNPresidentViewViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 14.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNPresidentViewViewController.h"
#import "PTNPresident.h"
#import "PTNPresidentDetailViewController.h"

static NSString *CellIdentifier = @"Cell";


@implementation PTNPresidentViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"President Lists";
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Presidents"
                                                         ofType:@"plist"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        self.presidents = [unarchiver decodeObjectForKey:@"Presidents"];
        [unarchiver finishDecoding];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presidents count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PTNPresident *p = self.presidents[indexPath.row];
    cell.textLabel.text = p.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PTNPresident *president = self.presidents[indexPath.row];
    PTNPresidentDetailViewController *detailController = [[PTNPresidentDetailViewController alloc] init];
    detailController.president = president;
    detailController.delegate = self;
    detailController.row = indexPath.row;
    
    [self.navigationController pushViewController:detailController animated:YES];
    
}

@end
