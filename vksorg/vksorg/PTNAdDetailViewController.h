//
//  PTNAdDetailViewController.h
//  vksorg
//
//  Created by petun on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNAdDetailViewController : UIViewController

@property (strong,nonatomic) NSDictionary *ad;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;

@end
