//
//  PTNPersonsViewController.h
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNPersonsViewController : UITableViewController <UISearchDisplayDelegate>

@property (copy,nonatomic) NSDictionary *persons;
@property (copy,nonatomic) NSArray *keys;

@property (strong,nonatomic) IBOutlet UISearchBar *searchBar;

@end
