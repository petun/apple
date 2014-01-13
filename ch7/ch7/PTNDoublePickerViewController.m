//
//  PTNDoublePickerViewController.m
//  ch7
//
//  Created by Admin on 09.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNDoublePickerViewController.h"

@interface PTNDoublePickerViewController ()

@end

@implementation PTNDoublePickerViewController

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
    
    self.fillingTypes = @[@"1",@"123",@"asas",@"another 1 list element"];
    self.breadTypes = @[@"2 1",@"2 2",@"2 3"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    NSInteger fillingRow = [self.pickerView selectedRowInComponent:0];
    NSInteger breadsRow = [self.pickerView selectedRowInComponent:1];
    
    NSString *filStr = self.fillingTypes[fillingRow];
    NSString *breadStr = self.breadTypes[breadsRow];
    
    NSLog(@"Select fillling %@ with bread %@",filStr,breadStr);
    
}


#pragma mark -
#pragma mark Picker Source Methods
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.fillingTypes.count;
    } else if (component == 1) {
        return self.breadTypes.count;
    }
    return 0;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

#pragma mark Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.fillingTypes[row];
    } else {
        return self.breadTypes[row];
    }
}


@end
