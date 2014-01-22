//
//  PTNAppDelegate.h
//  vsw-with-storyboard
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) NSArray *allPersons;
@property (strong,nonatomic) NSMutableDictionary *allDepartments;

@end
