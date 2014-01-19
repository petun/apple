//
//  PTNViewController.h
//  ch15-GCD
//
//  Created by petun on 19.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)doWork:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitiIndicator;

@end
