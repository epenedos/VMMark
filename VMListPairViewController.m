//
//  VMListPairViewController.m
//  VMMark
//
//  Created by epenedos on 3/18/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//


#import "VMTabBarController.h"
#import "VMListPairViewController.h"
#import "VMMarksResultsDataController.h"
#import "VMListOEMDetailsViewController.h"
#import "VMMarksResults.h"
#import "WebRequest.h"
#import "utl_csvParser.h"

#import "VMListPairCell.h"

#import <QuartzCore/QuartzCore.h>

@interface VMListPairViewController ()
@property (strong,nonatomic) NSMutableArray *pairList;
@property (strong,nonatomic) NSMutableArray *socketList;
@property (strong,nonatomic) NSMutableArray *pairListComplete;
@end

@implementation VMListPairViewController

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

   
    
    self.pairListComplete = [[NSMutableArray alloc] init];
    self.socketList = [[NSMutableArray alloc] init];
    
    VMTabBarController *master = (VMTabBarController *) self.parentViewController.parentViewController;
    self.marks = master.marks;
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(refreshInvoked) forControlEvents:UIControlEventValueChanged];
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
   
    if ([self.marks.results count] > 0) {
        [self processFetch];
    } else {
        [self refreshInvoked];
    }


    
    

    
}


-(void)refreshInvoked {
    
    
    [WebRequest requestPath:@"http://www.vmware.com/a/vmmark/1/?csv=1" onCompletion:^(NSString *result, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                // No Error
                [self stopFetching:result];
            } else {
                // Handle Error
                NSLog(@"ERROR: %@",error);
                [self stopFetching:@"Failed to Load"];
            }
        });
    }];
    
    
    
    [self.refreshControl endRefreshing];
}


-(void)stopFetching:(NSString *)result
{
    NSLog(@"Result Pair: %@",result);
    [self.marks loadResults:result];
    [self processFetch];
    
    
}

-(void) processFetch{
    
    [self.pairList removeAllObjects];
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"matchedPair contains[c] %@", @"1" ];
    self.pairList  =  [[NSMutableArray alloc] initWithArray:[self.marks.results filteredArrayUsingPredicate:predicate]];
   
 
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"totalSockets"
                                                 ascending:NO] ;
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    
    self.pairList = [[NSMutableArray alloc  ] initWithArray: [self.pairList sortedArrayUsingDescriptors:sortDescriptors]];
    
    // create the list of possible sockects
    
    [self.pairListComplete removeAllObjects];
    [self.socketList removeAllObjects];
    
    for (VMMarksResults *temp in self.pairList) {
        
        if (![self.socketList containsObject:temp.totalSockets]) {
            [self.socketList addObject:temp.totalSockets];
        }
    }
    
    
    
    for (NSString *temp in self.socketList) {
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"totalSockets == %@", temp ];
        NSArray *filtered  = [self.pairList filteredArrayUsingPredicate:predicate];
        NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"brandResultBench"
                                                     ascending:NO] ;
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *filteredAndOrdered = [[NSArray alloc  ] initWithArray: [filtered sortedArrayUsingDescriptors:sortDescriptors]];
        
        [self.pairListComplete addObject:filteredAndOrdered];
    }
    
    
    
    
    
    
    [[self tableView] reloadData];
    
    
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
    return [self.socketList count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.pairListComplete objectAtIndex:section] count];
}




- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = @"Total Sockets in the Pair - ";
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];

    [headerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"menubarflat.png"]]];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, tableView.bounds.size.width - 10, 18)];
    label.text = [title stringByAppendingString:[NSString stringWithFormat:@"%@",[self.socketList objectAtIndex:section]]];
    label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];

    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];

    return headerView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"myCellPair";
    VMListPairCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    VMMarksResults *onIndex = [[self.pairListComplete objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    NSString *s = [[NSString alloc] initWithString:onIndex.brandName];
    
    NSString *r  = [NSString stringWithFormat:@"%.2f @ ",[onIndex.brandResultBench doubleValue]];
    
    
    NSString *t = [r stringByAppendingString:onIndex.brandResultTiles];
    
    
    if ([s isEqualToString:@"Fujitsu"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"Fujitsu-Icon" ofType: @"jpg"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    
    if ([s isEqualToString:@"Cisco"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"cisco" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    
    if ([s isEqualToString:@"Dell"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"dell" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    if ([s isEqualToString:@"Hewlett-Packard"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"hp" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    if ([s isEqualToString:@"IBM"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"ibm" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    if ([s isEqualToString:@"AMD"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"amd" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }
    if ([s isEqualToString:@"Huawei"]) {
        NSString *imgFile = [[NSBundle mainBundle] pathForResource: @"huawei" ofType: @"png"];
        NSData *imgData = [[NSData alloc] initWithContentsOfFile:imgFile];
        UIImage *img = [[UIImage alloc] initWithData:imgData];
        [[cell brandLogo] setImage:img];
    }

    
    
    
    [[cell brandModel] setText:onIndex.brandModel];
    
    [[cell brandResult] setText:t];
    
    return cell;
}





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"listOEMDetailed"]) {
      
        VMListOEMDetailsViewController *detailViewController = [segue destinationViewController];
        VMMarksResults *s = [[VMMarksResults alloc] init];
        s = [[self.pairListComplete objectAtIndex:[self.tableView indexPathForSelectedRow].section] objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        detailViewController.vmmarkresult = s;
        
        [detailViewController setTitle:s.brandModel];
        
    }
}

@end
