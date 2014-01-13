//
//  PTNBaseViewController.h
//  chapter8
//
//  Created by Admin on 10.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNBaseViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (copy,nonatomic) NSArray *list;

@end
