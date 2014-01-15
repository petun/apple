//
//  PTNTaskDetailViewController.m
//  ср10-SegNav
//
//  Created by Admin on 15.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNTaskDetailViewController.h"

@interface PTNTaskDetailViewController ()

@end

@implementation PTNTaskDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// prepareForSegue работае только когда мы добавляем контроллер в верх стека
// и он не работает когда мы нажимаем кнопку назад
// viewWillDisappear как раз нужен в данный момент
-(void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // это вместо делегатов
    // проверяем, есть ли такой метод у объекта, и если есть
    // передаем туда параметры не вызввая метод, а с помощью технологии key-value coding (KVC)
    if ([self.delegate respondsToSelector:@selector(setBla:)]) {
        [self.textView endEditing:YES];
        
        NSIndexPath *path = self.selection[@"indexPath"];
        NSString *text = self.textView.text;
        
        NSDictionary *object = @{@"indexPath":path,@"object":text};
        
        [self.delegate setValue:object forKey:@"Bla"];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textView.text = self.selection[@"object"];
    [self.textView becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
