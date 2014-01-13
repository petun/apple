//
//  PTNDatePickerViewController.m
//  ch7
//
//  Created by Admin on 09.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDatePickerViewController.h"

@interface PTNDatePickerViewController ()

@end

@implementation PTNDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.calendar setDate:[NSDate date] animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    NSDate *date = [self.calendar date];
    NSString *message = [[NSString alloc] initWithFormat:@"Date is %@", date];
    NSLog(@"%@",message);
    
    [self.dLabel setText:message];
}
@end
