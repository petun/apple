//
//  PTNDetailViewController.h
//  m1
//
//  Created by petun on 09.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTNPerson.h"

@interface PTNDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *telephones;
@property (weak, nonatomic) IBOutlet UILabel *email;


@property IBOutlet UILabel* firstName;
@property IBOutlet UILabel* midName;
@property IBOutlet UILabel* lastName;

@property (weak, nonatomic) IBOutlet UIImageView *personImage;

@property (weak, nonatomic) IBOutlet UITextView *plans;



@property (weak, nonatomic) IBOutlet UITextView *orgEx;

@end
