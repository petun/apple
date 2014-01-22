//
//  PTNPersonsViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNPersonsViewController.h"
#import "PTNDetailPersonViewController.h"

static NSString * const CellIdentifier = @"Cell";


@interface PTNPersonsViewController ()

@end

@implementation PTNPersonsViewController {
    NSMutableArray *filteredPersons;
    UISearchDisplayController *searchController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Справочник сотрудников ЗАО ОМК";
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ps.binary" ofType:@"plist"];
        self.persons = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        self.keys = [[self.persons allKeys] sortedArrayUsingSelector:@selector(compare:)];
        // Custom initialization
        
        filteredPersons = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add search view controller
    searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSMutableDictionary *person = [[NSMutableDictionary alloc] init];
    
    if (tableView.tag == 1) {
        NSString *cKey = self.keys[indexPath.section];
        NSArray *persons = self.persons[cKey];
        [person setDictionary:persons[indexPath.row]];

    } else {
        [person setDictionary:filteredPersons[indexPath.row]];
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@", person[@"NACHN"],  person[@"VORNA"], person[@"MIDNM"]];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    
    
    cell.detailTextLabel.text = person[@"PLANS_TXT"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *person = [[NSMutableDictionary alloc] init];
    
    if (tableView.tag == 1) {
        NSString *cKey = self.keys[indexPath.section];
        NSArray *persons = self.persons[cKey];
        [person setDictionary:persons[indexPath.row]];
        
    } else {
        [person setDictionary:filteredPersons[indexPath.row]];
    }
    
    PTNDetailPersonViewController *personController = [[PTNDetailPersonViewController alloc] initWithStyle:UITableViewStylePlain];
    
    personController.person = person;
    
    [self.navigationController pushViewController:personController animated:YES];
}




@end
