//
//  PTNViewController.m
//  ch15-GCD
//
//  Created by petun on 19.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)jobOne {
    [NSThread sleepForTimeInterval:1];
    return @"Job One complite";
}


-(NSString *)jobTwo {
    [NSThread sleepForTimeInterval:5];
    return @"Job Two complite";
}

-(NSString *)jobThree {
    [NSThread sleepForTimeInterval:4];
    return @"Job jobThree complite";
}

-(NSString *)jobFour {
    [NSThread sleepForTimeInterval:1];
    return @"Job jobFour complite";
}


- (IBAction)doWork:(UIButton *)sender {
    NSLog(@"Job begins");
    
    self.startButton.enabled = NO;
    self.textView.text = @"";
    [self.activitiIndicator startAnimating];
    
    UIAlertView *aler =  [[UIAlertView alloc] initWithTitle:@"Загрузка данных" message:@"Пожалуйста подождите..." delegate:self  cancelButtonTitle:nil otherButtonTitles:nil];
    
    
    [aler show];

    // асинхронный блок
    // dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) - Очередь с приоритетом по умолчанию - второой параметр не испольуется  и всегда ноль
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSString *one = [self jobOne];
        
        // задачи можно распараллеливать, это делается с помощью групп внутри очереди
        __block NSString *two;
        __block NSString *three;
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            two = [self jobTwo];
        });
        
        dispatch_group_async(group, queue, ^{
            three = [self jobThree];
        });
        
        
        
        // данная функция будет вызвана тогда, когда завершит своб работы все процессы из этой группы
        dispatch_group_notify(group, queue, ^{
            NSString *four = [self jobFour];
            
            NSString *result = [[NSString alloc] initWithFormat:@"Result is: %@ %@ %@ %@",one,two,three,four];
            
            // тк элементы интерфейса нужно обновлять ТОЛЬКО из main thred - переключаемся на него
            dispatch_async(dispatch_get_main_queue(), ^{
                self.textView.text = result;
                self.startButton.enabled = YES;
                [self.activitiIndicator stopAnimating];
                
                [aler dismissWithClickedButtonIndex:0 animated:YES];
            });
        
        });
        
        
        
    });
    

}
@end
