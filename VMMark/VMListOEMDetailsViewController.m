//
//  VMListOEMDetailsViewController.m
//  VMMark
//
//  Created by epenedos on 3/12/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "VMListOEMDetailsViewController.h"

@interface VMListOEMDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *brandResults;
@property (weak, nonatomic) IBOutlet UILabel *brandVMWare;
@property (weak, nonatomic) IBOutlet UILabel *hosts;
@property (weak, nonatomic) IBOutlet UILabel *cpus;
@property (weak, nonatomic) IBOutlet UILabel *cores;
@property (weak, nonatomic) IBOutlet UILabel *threads;

@property (weak, nonatomic) IBOutlet UILabel *version;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *uniformHosts;

@property (weak, nonatomic) IBOutlet UILabel *matchedHosts;




@property (weak, nonatomic) IBOutlet UIBarButtonItem *callHelp;


@end

@implementation VMListOEMDetailsViewController


- (void)setVmmarkresult:(VMMarksResults *)vmmarkresult
{
    if (_vmmarkresult != vmmarkresult) {
        _vmmarkresult = vmmarkresult;
        
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

    
       
    [self.callHelp setBackgroundImage:[UIImage imageNamed:@"menubar-button.png"] forState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault];
    
    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor:bgColor];
        
   
    NSString *r  = [NSString stringWithFormat:@"%.2f @ ",[self.vmmarkresult.brandResultBench doubleValue]];
    NSString *sockets  = [NSString stringWithFormat:@"%d",[self.vmmarkresult.totalSockets integerValue]];
    
    NSString *t = [r stringByAppendingString:self.vmmarkresult.brandResultTiles];
    
    [self.brandResults setText:t];
    [self.brandVMWare setText:self.vmmarkresult.brandVMware];
    [self.hosts setText:self.vmmarkresult.totalHosts];
    [self.cpus setText:sockets];
    [self.cores setText:self.vmmarkresult.totalCores];
    [self.threads setText:self.vmmarkresult.totalThreads];
    [self.version setText:self.vmmarkresult.vmmarkVersion];
    if ([self.vmmarkresult.matchedPair isEqualToString:@"1"]) {
        [self.matchedHosts setText:@"Yes"];
    } else {
        [self.matchedHosts setText:@"No"];
    }
    
    if ([self.vmmarkresult.uniformHosts isEqualToString:@"1"]) {
        [self.uniformHosts setText:@"Yes"];
    } else {
        [self.uniformHosts setText:@"No"];
    }
    
    [self.date setText:self.vmmarkresult.date];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)toHelp:(id)sender {
}
@end
