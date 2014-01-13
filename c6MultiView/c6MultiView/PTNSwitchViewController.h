//
//  PTNSwitchViewController.h
//  c6MultiView
//
//  Created by Admin on 17.12.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTNBlueViewController.h"
#import "PTNYellowViewController.h"


@interface PTNSwitchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn1;
- (IBAction)buttonClicked:(id)sender;

@property (strong, nonatomic) PTNBlueViewController *blueController;
@property (strong, nonatomic) PTNYellowViewController *yellowController;

- (IBAction)switchView:(id)sender;




@end
