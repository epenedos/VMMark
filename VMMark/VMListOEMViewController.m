//
//  VMListViewController.m
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//
#import "VMTabBarController.h"
#import "VMListOEMViewController.h"
#import "VMListOEMCell.h"
#import "WebRequest.h"
#import "utl_csvParser.h"

#import "VMMarksResultsDataController.h"
#import "VMMarksResults.h"

#import "VMListOEMCompleteViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface VMListOEMViewController ()


@end

@implementation VMListOEMViewController 



- (void)awakeFromNib
{
    [super awakeFromNib];
    
    

   
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
    
    VMTabBarController *master = (VMTabBarController *) self.parentViewController.parentViewController;
    self.marks = master.marks;
    
    self.oemListComplete = [[NSMutableDictionary alloc] init];
    self.oemList = [[NSMutableArray alloc] init];

    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(refreshInvoked) forControlEvents:UIControlEventValueChanged];
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.view setBackgroundColor:bgColor];
    
    [self refreshInvoked];
    
    
    
    
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
    NSLog(@"Result LIST OEM: %@",result);
   
    
    [self.marks loadResults:result];
    
    [self processFetch];
 
}

-(void) processFetch {
    
    [self.oemList removeAllObjects];
    [self.oemListComplete removeAllObjects];
    
    for (VMMarksResults *temp in [self.marks results]) {
        
        if (![self.oemList containsObject:temp.brandName]) {
            [self.oemList addObject:temp.brandName];
        }
    }
    
    
    for (NSString *temp in self.oemList) {
        NSPredicate *predicate =
        [NSPredicate predicateWithFormat:@"brandName == %@", temp ];
        NSArray *filtered  = [[self.marks results] filteredArrayUsingPredicate:predicate];
        [self.oemListComplete setValue:filtered forKey:temp];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return [self.oemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyCell";
    VMListOEMCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *onIndex = [self.oemList objectAtIndex:indexPath.row];
    
    NSString *s = [[NSString alloc] initWithString:onIndex];
    
    [[cell brandLogo] setImage:nil];
  
    [[cell brandNum] setText:[NSString stringWithFormat:@"%d",[[self.oemListComplete objectForKey:s] count]]];
    
    [[cell brandName] setText:s];
    
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
        
  
    
    
    return cell;
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"listOEMComplete"]) {
        
        VMListOEMCompleteViewController *detailViewController = [segue destinationViewController];
        
        detailViewController.oemListResults = [self.oemListComplete objectForKey:[self.oemList objectAtIndex:[self.tableView indexPathForSelectedRow].row]];
        NSMutableString *title = [self.oemList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        if ([title isEqualToString:@"Hewlett-Packard"]) {
            title = [[NSMutableString alloc] initWithString:@"HP"];
        }
        
        [detailViewController setTitle:title];
        
        
    }
}


@end
