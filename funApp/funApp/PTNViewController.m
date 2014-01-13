//
//  PTNViewController.m
//  funApp
//
//  Created by Admin on 17.12.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import "PTNViewController.h"

@interface PTNViewController ()

@end

@implementation PTNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.sliderLabel setText:@"50"];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nameFieldDone:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    int progress = lround(sender.value);
    [self.sliderLabel setText:[NSString stringWithFormat:@"%d",progress]];
}
- (IBAction)switchChanged:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.pushButton.hidden = YES;
    } else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.pushButton.hidden = NO;
    }
}
- (IBAction)pushButtonClicked:(UIButton *)sender {
    NSLog(@"push buttonclicked");
    
    // generate actionSheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"title" delegate:self cancelButtonTitle:@"ChanheLL" destructiveButtonTitle:@"Go on!" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        NSLog(@"Success button clicked!!!");
        
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:@"All is ok" message:@"Messag here" delegate:nil cancelButtonTitle:@"OK. Hide window." otherButtonTitles:nil];
        
        [aView show];
    }
    
    NSLog(@"Dismiss with button index %d",buttonIndex     );
}



@end
