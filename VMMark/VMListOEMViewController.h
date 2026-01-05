//
//  VMListViewController.h
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VMMarksResultsDataController;  


@interface VMListOEMViewController : UITableViewController 
@property (strong,nonatomic) VMMarksResultsDataController *marks;
@property (strong,nonatomic) NSMutableArray *oemList;
@property (strong,nonatomic) NSMutableDictionary *oemListComplete;


@end
