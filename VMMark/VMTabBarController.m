//
//  VMTabBarController.m
//  vmbench
//
//  Created by epenedos on 3/22/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//
#import "VMMarksResultsDataController.h"
#import "VMTabBarController.h"
#import "VMListOEMViewController.h"
#import "VMListPairViewController.h"

@interface VMTabBarController ()

@end

@implementation VMTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.marks = [[VMMarksResultsDataController alloc] init];

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
