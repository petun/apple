//
//  PTNDetailViewController.m
//  ср11-Presidents
//
//  Created by petun on 15.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNDetailViewController.h"
#import "PTNLanguageListViewController.h"

@interface PTNDetailViewController ()

// какой то class extension
// это аналог private в других языках - такие свойста и методы не видны снаружи
// данной свойство задается с делегате UISplitViewControllerDelegate
// splitView дергает методы когда проиходит изменение ориентации планша
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
@end

@implementation PTNDetailViewController

-(void)toggleLanguagePopover:(id)sender {
    if (self.languagePopoverController == nil) {
        PTNLanguageListViewController *langPopoverController = [[PTNLanguageListViewController alloc] init];
        langPopoverController.detailViewController = self;
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:langPopoverController];
        
        [popover presentPopoverFromBarButtonItem:self.langueButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        self.languagePopoverController = popover;
    } else {
        // вызывается когда контроллер показывается на экране
        if (self.languagePopoverController != nil) {
            [self.languagePopoverController dismissPopoverAnimated:YES];
            self.languagePopoverController =  nil;
        }
    }
}

-(void)setLanguageString:(NSString *)newString {
    if (![newString isEqualToString:self.languageString]) {
        _languageString = [newString copy];
        self.detailItem = modifyUrlForLanguage(_detailItem, self.languageString);
    }
    
    if (self.languagePopoverController != nil) {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        // для того что бы скрывать popoover после выбора нового элемента
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}


static NSString * modifyUrlForLanguage(NSString *url, NSString *lang) {
    if (!lang) {
        return url;
    }
    
    // We're relying on a particular Wikipedia URL format here. This
    // is a bit fragile!
    NSRange languageCodeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:languageCodeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:languageCodeRange
                                                        withString:lang];
        return newUrl;
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
        NSURL *url = [NSURL URLWithString:self.detailItem];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // кнопка в сайдбар
    self.langueButton = [[UIBarButtonItem alloc] initWithTitle:@"select Lang" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleLanguagePopover:)];
    
    // добавляем ее на сайдбар
    self.navigationItem.rightBarButtonItem = self.langueButton;
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Presidents", @"Presidents");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
