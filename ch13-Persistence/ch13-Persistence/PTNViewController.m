//
//  PTNViewController.m
//  ch13-Persistence
//
//  Created by petun on 16.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNViewController.h"

@interface PTNViewController ()

@end

@implementation PTNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // self.lineFields - outlet collection  - просто массив с указателями на UITextField
    NSString *dataFilePath = [self dataFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataFilePath]) {
        NSArray *data = [[NSArray alloc] initWithContentsOfFile:dataFilePath];
        for (int i=0; i<=4; i++) {
            UITextField *field = self.lineFields[i];
            field.text = data[i];
        }
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    
    // selector - тот метод, который будет выполнятся
    // name - какого типа уведомления будем получать
    // object - уведомления, от которого будем получать уведомления
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResign:) name:UIApplicationWillResignActiveNotification object:app];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)appResign:(NSNotification *)notification
{
    NSString *filePath = [self dataFilePath];
    NSArray *array = [self.lineFields valueForKey:@"text"];
    [array writeToFile:filePath atomically:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// метод возвращает имя файла для записи
//
- (NSString *)dataFilePath {
    // NSDocumentDirectory  - search for Documents directory
    // NSUserDomainMask - search in app dir
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // only one element is returned - use it
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"data.list"];
}

@end
