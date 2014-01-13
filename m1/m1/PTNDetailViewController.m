//
//  PTNDetailViewController.m
//  m1
//
//  Created by petun on 09.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import "PTNDetailViewController.h"


@interface PTNDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *cTableView;


- (void)configureView;
@end

@implementation PTNDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
        
        [self.cTableView reloadData];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        PTNPerson * person = self.detailItem;
        
        self.title = person.fio;
        
        
        
        
        self.firstName.text = person.vorna;
        self.midName.text = person.midnm;
        self.lastName.text = person.nachn;
    
        
        //self.bukRs.text = person.bukrsName;
        self.plans.text = person.plans;
        self.orgEx.text = person.orgExTxt;
        
        self.telephones.text = person.tel;
        
        self.email.text = person.mail;
        
        NSLog(@"Load photo from url %@",person.photo);
        NSURL *url = [NSURL URLWithString:person.photo];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        self.personImage.image = image;
        
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
