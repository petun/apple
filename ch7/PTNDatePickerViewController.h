//
//  PTNDatePickerViewController.h
//  ch7
//
//  Created by Admin on 09.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDatePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dLabel;
- (IBAction)buttonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *calendar;



@end
