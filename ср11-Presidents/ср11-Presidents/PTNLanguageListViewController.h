//
//  PTNLanguageListViewController.h
//  ср11-Presidents
//
//  Created by Admin on 16.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTNDetailViewController;

@interface PTNLanguageListViewController : UITableViewController

@property (weak, nonatomic) PTNDetailViewController *detailViewController;
@property (strong,nonatomic) NSArray *languageNames;
@property (strong,nonatomic) NSArray *languageCodes;

@end
