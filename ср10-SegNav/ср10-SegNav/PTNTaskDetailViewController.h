//
//  PTNTaskDetailViewController.h
//  ср10-SegNav
//
//  Created by Admin on 15.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNTaskDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (copy, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id delegate;

@end
