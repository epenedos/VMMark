//
//  VMListOEMDetailsViewController.h
//  VMMark
//
//  Created by epenedos on 3/12/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMMarksResults.h"

@interface VMListOEMDetailsViewController : UITableViewController
@property (strong, nonatomic) VMMarksResults  *vmmarkresult;
- (IBAction)toHelp:(id)sender;

@end
