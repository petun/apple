//
//  PTNDetailPersonViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDetailPersonViewController.h"
#import "PTNDepartmentDetailViewController.h"
#import <AddressBook/AddressBook.h>
#import <QuartzCore/QuartzCore.h>

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
    
    NSString *name = [NSString stringWithFormat:@"%@", self.person[@"FIO"]];
    self.title = name;
    
    self.personNameLabel.text = name;
    
    self.rankLabel.text = self.person[@"PLANS_TXT"];;
    
    
    self.departmentLabel.text = self.person[@"ORGEH_TXT"];
    self.orgLabel.text = self.person[@"BUKRSNAME"];
    
    self.telephoneLabel.text = self.person[@"TEL01"];
    self.emailLabel.text = self.person[@"MAIL"];
    self.mobTelLabel.text = self.person[@"MTELL"];
    
    [self.loader startAnimating];
    
    [self.personPhoto.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    [self.personPhoto.layer setBorderWidth: 0.5];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *personUrl = [NSString stringWithFormat:@"http://webstat.vsw.ru:85/photos/300x400/%@.jpg",self.person[@"PERNR"]];
        
        NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:personUrl]];
        
        UIImage *image;
        if (data != nil) {
            image = [[UIImage alloc] initWithData:data];
        } else {
            NSString *nophoto = [[NSBundle mainBundle] pathForResource:@"nophoto" ofType:@"jpg"];
            image = [[UIImage alloc] initWithContentsOfFile:nophoto];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.personPhoto.image = image;
            [self.loader stopAnimating];

        });
    });    
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*if (indexPath.section == 0 && indexPath.row == 0) {
        NSLog(@"Add person to contact list");
        
        CFErrorRef err;
        ABAddressBookRef book = ABAddressBookCreateWithOptions(nil, &err);
        
        
        
        ABRecordRef person = ABPersonCreate();
        // Setting basic properties
        ABRecordSetValue(person, kABPersonFirstNameProperty, @"Ondrej" , nil);
        ABRecordSetValue(person, kABPersonLastNameProperty, @"Rafaj", nil);
        ABRecordSetValue(person, kABPersonJobTitleProperty, @"Tech. director", nil);
        ABRecordSetValue(person, kABPersonDepartmentProperty, @"iPhone development department", nil);
        ABRecordSetValue(person, kABPersonOrganizationProperty, @"Fuerte international", nil);
        ABRecordSetValue(person, kABPersonNoteProperty, @"The best iPhone development studio in the UK :)", nil);
        
        
        CFErrorRef addErr;
        ABAddressBookAddRecord(book,person,&addErr);
        
        
        
        
        
        // addressBook = ABAddressBookCreateWithOptions();
        //ABRecordRef person = ABPersonCreate();
    }*/
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
