//
//  PTNMoveMeViewController.m
//  chapter-9-many-tableviews
//
//  Created by petun on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNMoveMeViewController.h"

static NSString *CellIdentifier = @"cellID";

@interface PTNMoveMeViewController ()

@end

@implementation PTNMoveMeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Check one items";
        self.items = [[NSMutableArray alloc] initWithArray:@[@"One",@"Two",@"Three",@"Four"]];
        self.title = @"Move Me";
        
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    //[self.tableView setEditing:YES animated:YES];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = self.items[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Yes");
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

/* Нужен ли отступать икнокам, когда в режиме редактирования */
-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    id object = [self.items objectAtIndex:sourceIndexPath.row];
    [self.items removeObjectAtIndex:sourceIndexPath.row];
    [self.items insertObject:object atIndex:destinationIndexPath.row];

}

@end
