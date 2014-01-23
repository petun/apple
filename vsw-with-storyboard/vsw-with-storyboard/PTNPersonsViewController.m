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

#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

static NSString * const CellIdentifier = @"CellIdentifier";

// url до справочника
static NSString * const kPlistUrl = @"http://ps-devel-w334598178.omk-it.ru/netcat/modules/default/ps_flat.binary.plist";
// url до версиик
static NSString * const kPlistUrlVersion = @"http://ps-devel-w334598178.omk-it.ru/netcat/modules/default/ps_flat.binary.version.plist";
static NSString * const kReachabilityHost = @"ps-devel-w334598178.omk-it.ru";


static NSString * const kDateKey = @"last_date";



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
        
        // reset date - tmp
        //[[NSUserDefaults standardUserDefaults] setValue:nil forKey:kDateKey];
        
    }
    return self;
}

// path for directory
-(NSString *)pathForPlist {
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docFolder = paths[0];
    return [docFolder stringByAppendingPathComponent:@"persons.plist"];
}

// test internet connection
- (BOOL)connected
{
    Reachability* reachability = [Reachability reachabilityWithHostName:kReachabilityHost];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Загрузка справочника" message:@"Проверка соединения..." delegate:self cancelButtonTitle:@"Закрыть" otherButtonTitles:nil];
    [alert show];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // если есть инет - проверяем версию и далее если новая скачиваем ее
        if ([self connected]) {
            
            NSLog(@"Connection to %@ OK",kReachabilityHost);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert setMessage:@"Проверка новой версии..."];
            });
            // есил есть новая версия  - качаем
            if ([self isNewVersionAvailable]) {
                
                NSLog(@"New version is available");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert setMessage:@"Загрузка новой версии..."];
                });

                // тут нужен отдельный поток
                NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:kPlistUrl]];
                //
                
                // если данные слили сохраняем
                if (data != nil) {
                    NSLog(@"Save new version to file");
                    if ([data writeToFile:[self pathForPlist] atomically:YES]) {
                        // update version to new
                        [self updateVersion];
                    }
                } else {
                    NSLog(@"Failed to fetch data from %@",kPlistUrl);
                }
            } else {
                NSLog(@"Versions are the same.");
            }
        }
        // если справочник есть - используем его просто
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self pathForPlist]]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert dismissWithClickedButtonIndex:0 animated:YES];
                [self loadPlistToApp];
            });
        } else {
            // выводим сообщение о том что нет инета и нет справочника.. - exit
            NSLog(@"Failed to download catalog file...  exit");
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert setMessage:@"Ошибка при загрузке каталога, проверте, если у вас доступ до корпоративной сети ОМК."];
            });
        }
    });
}

-(BOOL)isNewVersionAvailable {
    
    if ([self connected]) {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:kPlistUrlVersion]];
        NSDate *serverDate = dict[kDateKey];
        if (serverDate != nil) {
            NSDate *currentDate = [[NSUserDefaults standardUserDefaults] valueForKey:kDateKey];
            
            NSLog(@"Check for new vesion: app: %@ / server: %@",[currentDate description],[serverDate description]);
            
            if (currentDate == nil || [currentDate compare:serverDate] != NSOrderedSame) {
                return YES;
            }
        }
        
    }
    return NO;
}

-(void)updateVersion {
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:kPlistUrlVersion]];
    NSDate *serverDate = dict[kDateKey];
    
    NSLog(@"Update default version to %@",[serverDate description]);
    // string representation
    [[NSUserDefaults standardUserDefaults] setValue:[serverDate descriptionWithLocale:[NSLocale currentLocale]]  forKey:@"version"];
    // date
    [[NSUserDefaults standardUserDefaults] setValue:serverDate forKey:kDateKey];

    
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadPlistToApp {
    // второй метод загрузки списка - сортировку делаем уже на месте
    // грузим плоский список сотрудникоффф
    self.appDelegate.allPersons = [[NSArray alloc] initWithContentsOfFile:[self pathForPlist]];
    self.appDelegate.allDepartments = [[NSMutableDictionary alloc] init];
    
    self.persons = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dict in self.appDelegate.allPersons) {
        // add persons
        NSString *firstLetter = [dict[@"FIO"] substringToIndex:1];
        
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
                NSString *surname = p[@"FIO"];
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", person[@"FIO"]];
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
