//
//  PTNDiscloseDetailViewController.h
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDiscloseDetailViewController : UIViewController

@property (copy,nonatomic) NSString *message;
@property (weak, readonly, nonatomic) UILabel *label;

@end
