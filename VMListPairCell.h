//
//  VMListPairCell.h
//  VMMark
//
//  Created by epenedos on 3/18/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VMListPairCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *brandLogo;
@property (weak, nonatomic) IBOutlet UILabel *brandModel;

@property (weak, nonatomic) IBOutlet UILabel *brandResult;

@end
