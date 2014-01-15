//
//  PTNDetailViewController.h
//  ср11-Presidents
//
//  Created by petun on 15.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
