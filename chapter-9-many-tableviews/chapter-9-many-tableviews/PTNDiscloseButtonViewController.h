//
//  PTNDiscloseButtonViewController.h
//  chapter-9-many-tableviews
//
//  Created by Admin on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNSecondViewController.h"
@class PTNDiscloseDetailViewController;

@interface PTNDiscloseButtonViewController : PTNSecondViewController

@property (strong,nonatomic) NSArray *movies;
@property (strong,nonatomic) PTNDiscloseDetailViewController *detailController;

@end
