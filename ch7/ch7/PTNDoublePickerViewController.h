//
//  PTNDoublePickerViewController.h
//  ch7
//
//  Created by Admin on 09.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDoublePickerViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong,nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *fillingTypes;
@property (strong,nonatomic) NSArray *breadTypes;

- (IBAction)buttonPressed:(id)sender;


@end
