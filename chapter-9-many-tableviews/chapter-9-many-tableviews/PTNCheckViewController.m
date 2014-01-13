//
//  PTNCheckViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNCheckViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface PTNCheckViewController ()

@end

@implementation PTNCheckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Check one items";
        self.snacks = @[@"One",@"Two",@"Three",@"Four"];
        
        self.selectedSnack = NSNotFound;
        
        self.title = @"check title here";

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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.snacks count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.snacks[indexPath.row];
    if (self.selectedSnack == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Yes");
    
    if (indexPath.row != self.selectedSnack) {
        if (self.selectedSnack != NSNotFound) {
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:self.selectedSnack inSection:0];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:oldPath];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        UITableViewCell *cellSelected = [tableView cellForRowAtIndexPath:indexPath];
        cellSelected.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedSnack = indexPath.row;
        
    }
    
    
}


@end
