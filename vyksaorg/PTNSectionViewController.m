//
//  PTNSectionViewController.m
//  vyksaorg
//
//  Created by Admin on 20.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNSectionViewController.h"
#import "PTNAppDelegate.h"

static NSString * const kCatEntity = @"Cat";

@interface PTNSectionViewController ()

@end

@implementation PTNSectionViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.appDelegate = [UIApplication sharedApplication].delegate;
        
         NSString *path = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"plist"];
         self.allSections = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.currentSection == nil) {
        self.sections = [self.allSections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(parent_id == %i)",0] ];
    } else {
        int currentCatId = [[self.currentSection valueForKey:@"id"] intValue];
        self.sections = [self.allSections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(parent_id == %i)",currentCatId] ];
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)downloadSections {
    /*if (items != nil) {
        // sync with database
        NSMutableArray *allCatIds = [NSMutableArray array];
        for (NSArray *section in items) {
            [allCatIds addObject:section[0]];
        }
        
        
        // create request
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:[NSEntityDescription entityForName:kCatEntity inManagedObjectContext:self.appDelegate.managedObjectContext]];
         
         [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(id IN %@)",allCatIds]];
         
         NSError *error;
         NSArray *catInDatabase = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
         
         // if succes query executed
         if (error == nil) {
             // insert only new items
             for (NSArray *section in items) {
                 NSNumber *catId = section[0];
                 NSNumber *parentId = section[1];
                 
                 
                 
             }

             
         }
        
        
    }*/
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
    return [self.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *category = self.sections[indexPath.row];
    cell.textLabel.text = category[@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cSection = self.sections[indexPath.row];
    
    UIStoryboard *storyboard = self.storyboard;
    PTNSectionViewController *catController = [storyboard instantiateViewControllerWithIdentifier:@"CategoryControllerId"];
    
    catController.allSections = self.allSections;
    catController.currentSection = cSection;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:catController];
    
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}


@end
