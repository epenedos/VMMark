//
//  VMListOEMCompleteViewController.h
//  VMMark
//
//  Created by epenedos on 3/7/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMListOEMCompleteViewController : UITableViewController 
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray  *oemListResults;
@property (strong,nonatomic) NSMutableArray *filtered;
@end
