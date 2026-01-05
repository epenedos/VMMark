//
//  VMTabBarController.h
//  vmbench
//
//  Created by epenedos on 3/22/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VMMarksResultsDataController; 
@interface VMTabBarController : UITabBarController
@property (strong,nonatomic) VMMarksResultsDataController *marks;
@end
