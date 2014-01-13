//
//  PTNViewController.h
//  funApp
//
//  Created by Admin on 17.12.13.
//  Copyright (c) 2013 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;

- (IBAction)nameFieldDone:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)sliderChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

- (IBAction)switchChanged:(UISwitch *)sender;
- (IBAction)segmentChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UIButton *pushButton;
- (IBAction)pushButtonClicked:(UIButton *)sender;




@end
