//
//  PTNGameViewController.h
//  ch7
//
//  Created by Admin on 10.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNGameViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong,nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) IBOutlet UILabel *winLabel;
@property (strong,nonatomic) IBOutlet UIButton *startButton;
@property (strong,nonatomic) NSArray *images;

-(IBAction)spin;

@end
