//
//  PTNControlsViewController.h
//  chapter-9-many-tableviews
//
//  Created by petun on 13.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNSecondViewController.h"

@interface PTNControlsViewController : PTNSecondViewController

@property (strong,nonatomic) NSArray *items;
-(IBAction)tappedButton:(UIButton *)sender;

@end
