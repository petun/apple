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
@property (weak,nonatomic) IBOutlet UIWebView *webView;

// кнопка для выбора языка
@property (strong,nonatomic) UIBarButtonItem *langueButton;

// контроллер popver - внутри которого будет LangueList controller
@property (strong,nonatomic) UIPopoverController *languagePopoverController;

@property (copy,nonatomic) NSString *languageString;

// действие, вызываемое по кнопке
-(IBAction)toggleLanguagePopover:(id)sender;

@end
