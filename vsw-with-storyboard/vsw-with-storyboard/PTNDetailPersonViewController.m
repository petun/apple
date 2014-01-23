//
//  PTNDetailPersonViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDetailPersonViewController.h"
#import "PTNDepartmentDetailViewController.h"

@interface PTNDetailPersonViewController ()

@end

@implementation PTNDetailPersonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *name = [NSString stringWithFormat:@"%@ %@ %@", self.person[@"NACHN"],  self.person[@"VORNA"], self.person[@"MIDNM"]];
    self.title = name;
    
    self.personNameLabel.text = name;
    
    self.rankLabel.text = self.person[@"PLANS_TXT"];;
    
    
    self.departmentLabel.text = self.person[@"ORGEH_TXT"];
    self.orgLabel.text = self.person[@"BUKRSNAME"];
    
    self.telephoneLabel.text = self.person[@"TEL01"];
    self.emailLabel.text = self.person[@"MAIL"];
    self.mobTelLabel.text = self.person[@"MTELL"];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // telephone calls
    if (cell.tag == 100) {
        NSString *number = cell.detailTextLabel.text;
        if (![number isEqualToString:@""]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",number]]];
        }
    }
    
    // send mail
    if (cell.tag == 105) {
        NSString *email = cell.detailTextLabel.text;
        if (![email isEqualToString:@""]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@",email]]];
        }
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare ForSegue");
    
    
    PTNDepartmentDetailViewController *dest = segue.destinationViewController;
    dest.departmentName = self.person[@"ORGEH_TXT"];
    dest.departmentNumber = self.person[@"ORGEH"];
    
    
}



@end
