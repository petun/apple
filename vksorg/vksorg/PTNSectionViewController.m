//
//  PTNSectionViewController.m
//  vksorg
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNSectionViewController.h"
#import "PTNAppDelegate.h"
#import "PTNAdViewController.h"

@interface PTNSectionViewController ()

@end

@implementation PTNSectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.appDelegate = [UIApplication sharedApplication].delegate;

        // если грузимся первый раз - загружаем все разделы и грузим секции
        if (self.appDelegate.allSections == nil) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"plist"];
            self.appDelegate.allSections = [[NSArray alloc] initWithContentsOfFile:path];
            
            
            // init self controller propertyes
            // надо переделть блок - задавать его как все - через сеттер currentSection
            self.title = @"VyksaOrg - бесплатные объявления";
            
            self.sections = [self.appDelegate.allSections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"parent_id = %i",0]];
            
            self.isSecitonContainer = YES;
            //
                  
        }
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
}

// setter for sections
-(void)setCurrentSection:(NSDictionary *)currentSection {
    _currentSection = currentSection;
    
    // set container or not
    self.isSecitonContainer = [[currentSection valueForKey:@"is_container"] boolValue];
    
    // set left title
    self.title = currentSection[@"name"];
   

    if (self.isSecitonContainer) {
        int sectionId = [currentSection[@"id"] integerValue];
        NSLog(@"Filter sections by parent_id = %i",sectionId);
        
        // set sections
        self.sections = [self.appDelegate.allSections filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"parent_id = %i",sectionId ]];
        
    }
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *csection = self.sections[indexPath.row];
    cell.textLabel.text = csection[@"name"];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *cSection = self.sections[indexPath.row];
    
    BOOL isContainer = [[cSection valueForKey:@"is_container"] boolValue];
    
    if (isContainer) {
        PTNSectionViewController *sectionController = [[PTNSectionViewController alloc] initWithStyle:UITableViewStylePlain];
        sectionController.currentSection = cSection;
        
        [self.navigationController pushViewController:sectionController animated:YES];
    } else {
        PTNAdViewController *adController = [[PTNAdViewController alloc] initWithStyle:UITableViewStylePlain];
        adController.currentSection = cSection;
        [self.navigationController pushViewController:adController animated:YES];
    }
    
    
    
}

@end
