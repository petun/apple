//
//  PTNMasterViewController.m
//  m1
//
//  Created by petun on 09.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import "PTNMasterViewController.h"

#import "PTNDetailViewController.h"
#import "PTNXmlParserDelegate.h"




@implementation PTNMasterViewController

-(NSMutableArray*)objects {
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _objects;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    // сразу показываем searchBar
    if ([self.searchBar.text isEqualToString:@""])
        [self.searchBar becomeFirstResponder];
 
    self.searchBar.delegate = self;
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"channel");
    
    //self.tableView.allowsSelection = YES;
    //self.tableView.scrollEnabled = YES;
    
    // убираем search bar елси он стоял
    [self.searchBar resignFirstResponder];

    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
  //  [searchBar setShowsCancelButton:YES animated:YES];
    
   // self.tableView.allowsSelection = NO;
    //self.tableView.scrollEnabled = NO;
    
    NSLog(@"searchBarTextDidBeginEditing");
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.objects removeAllObjects];
    
    /*PTNPerson* p1 = [PTNPerson new];
    p1.nachn = @"Марочкин";
    p1.vorna = @"Петр";
    p1.midnm = @"Евгеньевич";
    p1.bukrsName = @"Ведущий специалист";
    p1.orgExTxt = @"ОМК-ИТ";
    p1.pernr = [[NSNumber alloc] initWithInt:48208];
    [self.objects addObject:p1];
    
    PTNPerson* p2 = [PTNPerson new];
    p2.nachn = @"Игнатенков";
    p2.vorna = @"Никита";
    p2.midnm = @"Владимирович";
    p2.bukrsName = @"специалист";
    p2.orgExTxt = @"ОМК-ИТ";
    p2.tel01 = @"9945";
    p2.mail = @"ignatenkov_nv@vsw.ru";
    p2.pernr = [[NSNumber alloc] initWithInt:48208];
    [self.objects addObject:p2];
    
    PTNPerson* p3 = [PTNPerson new];
    p3.nachn = @"Босяк";
    p3.vorna = @"Александр";
    p3.midnm = @"";
    p3.bukrsName = @"специалист";
    p3.orgExTxt = @"ОМК-ИТ";
    p3.pernr = [[NSNumber alloc] initWithInt:48208];
    [self.objects addObject:p3];*/
    
    
    
    CFStringRef cfSearchText = (__bridge CFStringRef)searchBar.text;
    
    NSString *escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                 NULL,                                                                                                             cfSearchText,
                                                                                  NULL,
CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                                        kCFStringEncodingUTF8));
    
    NSString* url = [NSString stringWithFormat:@"http://ps.vsw.ru/persons/persons.xml?search=%@",escapedString];
    NSURL * xmlUrl  = [NSURL URLWithString:url];
    
    NSXMLParser * parser =  [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
    
    PTNXmlParserDelegate * d = [PTNXmlParserDelegate new];
    
    
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(100,100)]; // I do this because I'm in landscape mode
    [self.view addSubview:spinner]; // spinner is not visible until started
    
    spinner.hidesWhenStopped = YES;
    [spinner startAnimating];
    
    [parser setDelegate:d];
    [parser parse];
    
    while ( ! d.done )
        sleep(1);
    
    [spinner stopAnimating];

    [self.objects addObjectsFromArray:d.personCollection];
    


    
    NSLog(@"- searchBarSearchButtonClicked");
    
    self.tableView.allowsSelection = YES;
    self.tableView.scrollEnabled = YES;
    
    [self.tableView reloadData];
    
    
    // search
    [self.searchBar resignFirstResponder];

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}



/*- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}*/



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    
    PTNPerson* person = self.objects[indexPath.row];
    cell.textLabel.text = person.fio;
    
   /* NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description]; */
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
