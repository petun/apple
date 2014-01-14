//
//  PTNPresidentDetailViewController.m
//  chapter-9-many-tableviews
//
//  Created by Admin on 14.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNPresidentDetailViewController.h"
#import "President.h"

#define kNumberOfEditableRows         4
#define kNameRowIndex                 0
#define kFromYearRowIndex             1
#define kToYearRowIndex               2
#define kPartyIndex                   3



#define kLabelTag                     2048
#define kTextFieldTag                 4094

    static NSString *CellIdentifier = @"Cell";

@implementation PTNPresidentDetailViewController {
    // заполняется при начале редактирования каждого текстового поля
    NSString *initialText;
    // признак изменения данных
    BOOL hasChanges;
}


-(void)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save:(id)sender {
    [self.view endEditing:YES];
    if (hasChanges) {
        // сообщаем делегату об изменении данных, передаем новый объект и сам контроллер, у которого есть св-во row
        [self.delegate presidentDetailViewController:self didUpdatePresident:self.president];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDone:(id)sender {
    [sender resignFirstResponder];
}

// set Title for controller
-(void)setPresident:(President *)president {
    _president = president;
    self.title = president.name;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.fieldLabels = @[@"Name:", @"From:", @"To:", @"Party:"];
       
        
        // инициализация левой и правой кнопки для нав бара
        self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc]
         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
         target:self
         action:@selector(cancel:)];
        
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]
         initWithBarButtonSystemItem:UIBarButtonSystemItemSave
         target:self
         action:@selector(save:)];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelection = NO;
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kNumberOfEditableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // тут мы специально не регим предварительно ячейку, тк нам нужно к каждой ячейке добавить лейблы - один для правки второй для отображения названия поля, тут это возвращает всегда nil^ тк ячеек мало
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    // создаем ячейку, если нужно
    // заполняем ее двумя лейблами
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        UILabel *label = [[UILabel alloc] initWithFrame:
                          CGRectMake(10, 10, 75, 25)];
        label.tag = kLabelTag;
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:
                                  CGRectMake(90, 12, 200, 25)];
        textField.tag = kTextFieldTag;
        textField.clearsOnBeginEditing = NO;
        textField.delegate = self;
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self
                      action:@selector(textFieldDone:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
    }
    
    // заполняем значениями
    UILabel *label = (id)[cell viewWithTag:kLabelTag];
    label.text = self.fieldLabels[indexPath.row];
    
    UITextField *textField = (id)[cell viewWithTag:kTextFieldTag];
    textField.superview.tag = indexPath.row;
    
    switch (indexPath.row) {
        case kNameRowIndex:
            textField.text = self.president.name;
            break;
        case kFromYearRowIndex:
            textField.text = self.president.fromYear;
            break;
        case kToYearRowIndex:
            textField.text = self.president.toYear;
            break;
        case kPartyIndex:
            textField.text = self.president.party;
            break;
        default:
            break;
    }
    
    return cell;
}

// заполняем инит текст
#pragma mark UILabel Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    initialText = textField.text;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (![textField.text isEqualToString:initialText]) {
        hasChanges = YES;
        switch (textField.superview.tag) {
            case kNameRowIndex:
                self.president.name = textField.text;
                break;
            case kFromYearRowIndex:
                self.president.fromYear = textField.text;
                break;
            case kToYearRowIndex:
                self.president.toYear = textField.text;
                break;
            case kPartyIndex:
                self.president.party = textField.text;
                break;
            default:
                break;
        }
    }
}



@end
