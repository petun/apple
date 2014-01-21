//
//  PTNSectionViewController.h
//  vksorg
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PTNAppDelegate;

@interface PTNSectionViewController : UITableViewController

@property (strong,nonatomic) NSArray *sections;
@property (strong,nonatomic) PTNAppDelegate *appDelegate;

@property (strong,nonatomic)NSDictionary *currentSection;

@property BOOL isSecitonContainer;

@end
