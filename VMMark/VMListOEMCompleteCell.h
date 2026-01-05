//
//  VMListOEMCompleteCell.h
//  VMMark
//
//  Created by epenedos on 3/7/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMListOEMCompleteCell : UITableViewCell <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *brandModel;
@property (weak, nonatomic) IBOutlet UILabel *brandVMware;
@property (weak, nonatomic) IBOutlet UILabel *brandResults;
@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *hosts;
@property (weak, nonatomic) IBOutlet UILabel *cores;
@property (weak, nonatomic) IBOutlet UILabel *cpus;
@property (weak, nonatomic) IBOutlet UILabel *threads;
@property (weak, nonatomic) IBOutlet UILabel *dataMark;

@end
