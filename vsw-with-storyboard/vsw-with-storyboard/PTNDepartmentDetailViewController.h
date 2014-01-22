//
//  PTNDepartmentDetailViewController.h
//  vsw-with-storyboard
//
//  Created by petun on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDepartmentDetailViewController : UITableViewController

@property (strong,nonatomic) NSString *departmentName;
@property (strong,nonatomic) NSString *departmentNumber;
@property (strong,nonatomic) NSArray *departmentPersonal;

@end
