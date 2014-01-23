//
//  PTNDetailPersonViewController.h
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDetailPersonViewController : UITableViewController

@property (strong,nonatomic) NSDictionary *person;

@property (weak, nonatomic) IBOutlet UILabel *personNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *orgLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobTelLabel;

@property (weak, nonatomic) IBOutlet UIImageView *personPhoto;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loader;


@end
