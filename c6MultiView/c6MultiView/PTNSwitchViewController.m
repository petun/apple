//
//  PTNSwitchViewController.m
//  c6MultiView
//
//  Created by Admin on 17.12.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "PTNSwitchViewController.h"

@interface PTNSwitchViewController ()

@end

@implementation PTNSwitchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)init {
    self = [super initWithNibName:@"SwitchView" bundle:nil];
    if (self != nil) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"SwitchView Loads");
    
    self.blueController = [[PTNBlueViewController alloc] initWithNibName:@"BlueView" bundle:nil];
    
  
    [self.view insertSubview:self.blueController.view atIndex:0];
	// Do any additional setup after loading the view.l
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClicked:(id)sender {
    NSLog(@"Button clicked");
}

- (IBAction)switchView:(id)sender {
    NSLog(@"switchedView");
    
    if (self.yellowController.view.superview == nil) {
        if (self.yellowController == nil) {
            self.yellowController = [[PTNYellowViewController alloc] initWithNibName:@"YellowView" bundle:nil];
        }
        [self.blueController.view removeFromSuperview];
        [self.view insertSubview:self.yellowController.view atIndex:0];
    } else {
        [self.yellowController.view removeFromSuperview];
        [self.view insertSubview:self.blueController.view atIndex:0];
    }

}


@end
