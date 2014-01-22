//
//  PTNPersonsViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNPersonsViewController.h"
#import "PTNDetailPersonViewController.h"
#import "PTNAppDelegate.h"

static NSString * const CellIdentifier = @"CellIdentifier";
static NSString * const kPlistUrl = @"http://petrmarochkin.ru/ps_flat.binary.plist";


@interface PTNPersonsViewController ()

@end

@implementation PTNPersonsViewController {
    NSMutableArray *filteredPersons;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        filteredPersons = [NSMutableArray new];
        self.appDelegate = [UIApplication sharedApplication].delegate;
        
    }
    return self;
}

// path for directory
-(NSString *)pathForPlist {
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docFolder = paths[0];
    return [docFolder stringByAppendingPathComponent:@"persons.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // load file and init table
    // если нет файла - пытаемся загрузить из сети его
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self pathForPlist]]) {
        NSLog(@"Start downloading plist from %@",kPlistUrl);
        
        NSURL *url = [[NSURL alloc] initWithString:kPlistUrl];
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Загрузка справочника" message:@"Немного подождите..." delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
        [alert show];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // тут нужен отдельный поток
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            //
            
            if (data != nil) {
                [data writeToFile:[self pathForPlist] atomically:YES];
                
                //
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert dismissWithClickedButtonIndex:0 animated:YES];
                    [self loadPlistToApp];
                });
                
            } else {
                NSLog(@"Failed to download catalog file...  exit");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert setMessage:@"Ошибка при загрузке каталога, проверте, если у вас доступ до корпоративной сети ОМК."];
                });
            }
        });
        
    } else {
        [self loadPlistToApp];
    }
}

-(void)loadPlistToApp {
    // второй метод загрузки списка - сортировку делаем уже на месте
    // грузим плоский список сотрудникоффф
    self.appDelegate.allPersons = [[NSArray alloc] initWithContentsOfFile:[self pathForPlist]];
    self.appDelegate.allDepartments = [[NSMutableDictionary alloc] init];
    
    self.persons = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in self.appDelegate.allPersons) {
        // add persons
        NSString *firstLetter = [dict[@"NACHN"] substringToIndex:1];
        
        if (self.persons[firstLetter] == nil) {
            [self.persons setValue:[NSMutableArray array] forKey:firstLetter];
        }
        
        [self.persons[firstLetter] addObject:dict];
        
        // add departments
        NSString *departmenrNumber = dict[@"ORGEH"];
        
        if (self.appDelegate.allDepartments[departmenrNumber] == nil) {
            [self.appDelegate.allDepartments setValue:dict[@"ORGEH_TXT"] forKey:departmenrNumber];
        }
    }
    
    self.keys = [[self.persons allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Search Delegate
// init for loading tableView
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [filteredPersons removeAllObjects];
    if ([searchString length] > 1) {
        
        NSString *firstLetter = [[searchString substringToIndex:1] uppercaseString];
        
        if (self.persons[firstLetter] != nil) {
            
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *p, NSDictionary *b){
                NSString *surname = p[@"NACHN"];
                NSRange range = [surname rangeOfString:searchString options:NSCaseInsensitiveSearch];
                
                //NSLog(@"%i",range.location);
                return range.location == 0;
            }];
            
            NSArray *mathes = [self.persons[firstLetter] filteredArrayUsingPredicate:predicate ];
            [filteredPersons addObjectsFromArray:mathes];
           
        }
        //NSLog(@"Found filtered persons - %i",[filteredPersons count]);
    }
    
    return YES;
}

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
   // тут два варианта - либо делать отдельно nib для tableView с поиском, либо просто всегда брать ячейки из self.tableView в методе cellForRowAtIndexPath
    // [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1) {
        return [self.keys count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 1) {
        NSString *cKey = self.keys[section];
        NSArray *persons = self.persons[cKey];
        return [persons count];
    } else {
        return [filteredPersons count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSMutableDictionary *person = [[NSMutableDictionary alloc] init];
    
    if (tableView.tag == 1) {
        NSString *cKey = self.keys[indexPath.section];
        NSArray *persons = self.persons[cKey];
        [person setDictionary:persons[indexPath.row]];

    } else {
        [person setDictionary:filteredPersons[indexPath.row]];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", person[@"NACHN"],  person[@"VORNA"], person[@"MIDNM"]];
    cell.detailTextLabel.text = person[@"PLANS_TXT"];
    
    cell.tag = indexPath.row;   
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
                return self.keys[section];
    } else {
        return nil;
    }

}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView.tag == 1) {
            return self.keys;
    } else {
        return nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepare %@",segue.identifier);
 
    NSMutableDictionary *person = [[NSMutableDictionary  alloc] init];
    if (self.searchDisplayController.isActive) {
        NSIndexPath *path = [self.searchDisplayController.searchResultsTableView indexPathForCell:sender];
        [person setDictionary:filteredPersons[path.row]];
    } else {
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        
        NSString *key = self.keys[path.section];
        [person setDictionary: self.persons[key][path.row]];
    }
    

    PTNDetailPersonViewController *dest = segue.destinationViewController;
    dest.person = person;
    
}


#pragma mark AlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Fuck");
}






@end
