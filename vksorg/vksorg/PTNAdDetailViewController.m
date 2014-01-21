//
//  PTNAdDetailViewController.m
//  vksorg
//
//  Created by petun on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNAdDetailViewController.h"

@interface PTNAdDetailViewController ()

@end

@implementation PTNAdDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setAd:(NSDictionary *)ad {
    _ad = ad;
    self.title = @"Детали объявления";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
