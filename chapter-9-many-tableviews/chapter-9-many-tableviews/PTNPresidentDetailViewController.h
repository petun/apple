//
//  PTNPresidentDetailViewController.h
//  chapter-9-many-tableviews
//
//  Created by Admin on 14.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class President;
@protocol PTNPresidentDetailViewControllerDelegate;



@interface PTNPresidentDetailViewController : UITableViewController <UITextFieldDelegate>


@property (copy,nonatomic) President *president;
@property (weak,nonatomic) id<PTNPresidentDetailViewControllerDelegate> delegate;
@property (assign, nonatomic) NSInteger row;


@property (strong,nonatomic) NSArray *fieldLabels;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;

@end





@protocol PTNPresidentDetailViewControllerDelegate <NSObject>

-(void) presidentDetailViewController:(PTNPresidentDetailViewController *)controller didUpdatePresident:(President *)president;

@end


