//
//  PTNMasterViewController.h
//  m1
//
//  Created by petun on 09.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNMasterViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic,strong) NSMutableArray *  objects;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end
