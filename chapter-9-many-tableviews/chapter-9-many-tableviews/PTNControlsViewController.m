//
//  PTNControlsViewController.m
//  chapter-9-many-tableviews
//
//  Created by petun on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNControlsViewController.h"

static NSString *cellIdentifier = @"cellId";

@interface PTNControlsViewController ()

@end

@implementation PTNControlsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.items = @[@"Item 1",@"Item 2"];
        self.title = @"Controlrs title";
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tappedButton:(UIButton *)sender {
    NSLog(@"Sender clicked %d",sender.tag);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %d",indexPath.row);
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    cell.textLabel.text = self.items[indexPath.row];
    
    // init button
    if (cell.accessoryView == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.titleLabel.text = @"click Me";
        [button setTitle:@"Title" forState:UIControlStateNormal];
        [button sizeToFit];
        button.tag = indexPath.row;
        [button addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.accessoryView = button;
    }
    cell.accessoryView.tag = indexPath.row;
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}




@end
