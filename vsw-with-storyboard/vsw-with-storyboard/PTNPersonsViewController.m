//
//  PTNPersonsViewController.m
//  vswpersons
//
//  Created by Admin on 22.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNPersonsViewController.h"
#import "PTNDetailPersonViewController.h"

static NSString * const CellIdentifier = @"CellIdentifier";


@interface PTNPersonsViewController ()

@end

@implementation PTNPersonsViewController {
    NSMutableArray *filteredPersons;
    UISearchDisplayController *searchController;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*NSMutableDictionary *person = [[NSMutableDictionary alloc] init];
    
    if (tableView.tag == 1) {
        NSString *cKey = self.keys[indexPath.section];
        NSArray *persons = self.persons[cKey];
        [person setDictionary:persons[indexPath.row]];
        
    } else {
        [person setDictionary:filteredPersons[indexPath.row]];
    }
    
    PTNDetailPersonViewController *personController = [[PTNDetailPersonViewController alloc] initWithStyle:UITableViewStylePlain];
    
    personController.person = person;
    
    [self.navigationController pushViewController:personController animated:YES];*/
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
    
    // Get the new view controller using .
    // Pass the selected object to the new view controller.
}






@end
