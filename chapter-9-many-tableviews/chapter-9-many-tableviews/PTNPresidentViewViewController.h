//
//  PTNPresidentViewViewController.h
//  chapter-9-many-tableviews
//
//  Created by Admin on 14.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNSecondViewController.h"
#import "PTNPresidentDetailViewController.h"

@interface PTNPresidentViewViewController : PTNSecondViewController <PTNPresidentDetailViewControllerDelegate>


@property (strong,nonatomic) NSMutableArray *presidents;

@end
