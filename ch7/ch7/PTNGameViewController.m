//
//  PTNGameViewController.m
//  ch7
//
//  Created by Admin on 10.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNGameViewController.h"

@interface PTNGameViewController ()

@end

@implementation PTNGameViewController {
    
}

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
    
    self.images = @[
        [UIImage imageNamed:@"car.png"],
        [UIImage imageNamed:@"caravan.png"],
        [UIImage imageNamed:@"card-in.png"],
        [UIImage imageNamed:@"caution.png"],
        [UIImage imageNamed:@"cctv.png"]
    ];
    
//    srandom(time(nil));
                    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark Picker Data Source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.images count];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImage *image = self.images[row];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    return imageView;
}

#pragma mark buttons
-(IBAction)spin {
    self.startButton.hidden = YES;
    for (int i=0; i<5; i++) {
        int newValue = random() % [self.images count];
        [self.pickerView selectRow:newValue inComponent:i animated:YES];
        [self.pickerView reloadComponent:i];
    }
    self.startButton.hidden = NO;
}

@end
