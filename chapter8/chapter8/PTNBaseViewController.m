//
//  PTNBaseViewController.m
//  chapter8
//
//  Created by Admin on 10.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNBaseViewController.h"

@interface PTNBaseViewController ()

@end

@implementation PTNBaseViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.list = @[ @"Телефон",@"E-mail",@"Местоположение",@"Должность" ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark lists
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableId = @"SId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableId];
    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:50];
    cell.textLabel.text = self.list[indexPath.row];
    cell.detailTextLabel.text = @"Сортировщик сдатчик труб большого диаметра";
    cell.imageView.image = [UIImage imageNamed:@"start.png"];
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return nil;
    }
    return indexPath;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rowValue = self.list[indexPath.row];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Row selected" message:rowValue delegate:nil cancelButtonTitle:@"Отмена" otherButtonTitles:nil];
    
    [alert show];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}





@end
