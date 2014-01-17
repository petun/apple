//
//  PTNViewController.m
//  CoreData
//
//  Created by petun on 18.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNViewController.h"
#import "PTNAppDelegate.h"

static NSString * const kLineEntityName = @"Line";
static NSString * const kLineNumberKey = @"lineNumber";
static NSString * const kLineTextKey = @"lineText";

@interface PTNViewController ()

@end

@implementation PTNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // тк мы используем шаблон с coredata в appdelegate уже есть код для инициализации и управления CoreData
    PTNAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    // контекст содается делегатом уже с шаблоном 
    NSManagedObjectContext *context = delegate.managedObjectContext;

    // запрос
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"eroror while get data");
        
    }
    
    // NSManagedObject - класс, предоставляющий доступ к экземплярам CoreData
    // для доступа и записи данных используется key coding
    for (NSManagedObject *oneObject in objects) {
        int lineNum = [[oneObject valueForKey:kLineNumberKey] integerValue];
        NSString *value = [oneObject valueForKey:kLineTextKey];
        
        UITextField *field =  self.lineFields[lineNum];
        field.text = value;
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AppClosed:) name:UIApplicationWillResignActiveNotification object:app];
    
}


-(void)AppClosed:(NSNotification *)notification {
    NSLog(@"APP closed");
    
    PTNAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSError *error;

    for (int i=0; i<=4; i++) {
        UITextField *field = self.lineFields[i];
        
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:kLineEntityName];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %d)",kLineNumberKey,i];
        
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"error");
        }
        
        NSManagedObject *object = nil;
        if ([objects count] == 0) {
            // создаем новый объект
            object = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName inManagedObjectContext:context];
        } else {
            // если селект вернул значение строки
            object = [objects objectAtIndex:0];
        }
        
        [object setValue:field.text forKey:kLineTextKey];
        [object setValue:[NSNumber numberWithInt:i] forKey:kLineNumberKey];
        
        
    }
    
    [delegate saveContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
