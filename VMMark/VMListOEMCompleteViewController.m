//
//  VMListOEMCompleteViewController.m
//  VMMark
//
//  Created by epenedos on 3/7/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "VMListOEMCompleteViewController.h"
#import "VMListOEMCompleteCell.h"
#import "VMMarksResults.h"
#import "VMListOEMDetailsViewController.h"

@interface VMListOEMCompleteViewController ()

@end

@implementation VMListOEMCompleteViewController


- (void)setOemListResults:(NSArray *)oemListResults
{
    if (_oemListResults != oemListResults) {
        _oemListResults = oemListResults;
        
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brandResultBench"
                                                      ascending:NO] ;
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
                
        _filtered = [[NSMutableArray alloc  ] initWithArray: [oemListResults sortedArrayUsingDescriptors:sortDescriptors]];
        
        
        
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar showsCancelButton];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
  //  [self.navigationItem.backBarButtonItem setBackgroundImage:[UIImage imageNamed:@"menubar-button.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];

    self.tableView.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
    
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"menubarflat.png"]];
    
    
    
    for (UIView *subView in self.searchBar.subviews){
        if([subView isKindOfClass:[UIButton class]]){
            
            [(UIButton *)subView setBackgroundImage:[UIImage imageNamed:@"menubar-button.png"] forState:UIControlStateNormal];
        }
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

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.filtered count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCellOEMComplete";
    VMListOEMCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    VMMarksResults *onIndex = [self.filtered objectAtIndex:indexPath.row];
    
    NSString *r  = [NSString stringWithFormat:@"%.2f @ ",[onIndex.brandResultBench doubleValue]];
    NSString *sockets  = [NSString stringWithFormat:@"%d",[onIndex.brandResultBench integerValue    ]];

   
  
    NSString *t = [r stringByAppendingString:onIndex.brandResultTiles];
    
    
    [[cell brandModel] setText:onIndex.brandModel];
    [[cell brandVMware] setText:onIndex.brandVMware];
    [[cell brandResults] setText:t];
    [[cell version] setText:onIndex.vmmarkVersion];
    [[cell hosts] setText:onIndex.totalHosts];
    [[cell cpus] setText:sockets];
    [[cell cores] setText:onIndex.totalCores];
    [[cell threads] setText:onIndex.totalThreads];
    [[cell dataMark] setText:onIndex.date];
    
    return cell;
}





- (void)searchbarTextBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
 
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
        [self handleSearch:searchBar];
}

- (void)handleSearch:(UISearchBar *)searchBar {
    NSLog(@"User searched for %@", searchBar.text);
    [searchBar resignFirstResponder];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"brandModel contains[c] %@", searchBar.text ];
    self.filtered  =  [[NSMutableArray alloc] initWithArray:[self.oemListResults filteredArrayUsingPredicate:predicate]];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brandResultBench"
                                                 ascending:NO] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.filtered = [[NSMutableArray alloc  ] initWithArray: [self.filtered sortedArrayUsingDescriptors:sortDescriptors]];
    
    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
    
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder];
    self.filtered = [[NSMutableArray alloc] initWithArray:self.oemListResults];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brandResultBench"
                                                 ascending:NO] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    self.filtered = [[NSMutableArray alloc  ] initWithArray: [self.filtered sortedArrayUsingDescriptors:sortDescriptors]];

    [self.tableView reloadData];
    self.tableView.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"listOEMDetailed"]) {
        self.tableView.contentOffset = CGPointMake(0, self.searchBar.frame.size.height);
        VMListOEMDetailsViewController *detailViewController = [segue destinationViewController];
        VMMarksResults *s = [[VMMarksResults alloc] init];
        s = [self.filtered objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.vmmarkresult = s;
        
        [detailViewController setTitle:s.brandModel];
        
    }
}



@end
