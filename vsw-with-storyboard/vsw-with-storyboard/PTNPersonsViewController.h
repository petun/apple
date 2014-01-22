//
//  PTNPersonsViewController.h
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTNAppDelegate;

@interface PTNPersonsViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong,nonatomic) NSMutableDictionary *persons;

@property (copy,nonatomic) NSArray *keys;

@property (strong,nonatomic) PTNAppDelegate *appDelegate;




@end
