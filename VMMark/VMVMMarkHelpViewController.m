//
//  VMVMMarkHelpViewController.m
//  VMMark
//
//  Created by epenedos on 3/16/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "VMVMMarkHelpViewController.h"
#import "QuartzCore/QuartzCore.h"

@interface VMVMMarkHelpViewController ()
- (IBAction)zoom:(UIPinchGestureRecognizer *)sender;
@property (nonatomic) CGFloat lastScale;
@property (weak, nonatomic) IBOutlet UITextView *help;
@end

@implementation VMVMMarkHelpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor* bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ipad-BG-pattern.png"]];
    
    [self.help setBackgroundColor:bgColor];
    
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)zoom:(UIPinchGestureRecognizer *)sender {
    
    if([sender state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales
        self.lastScale = [sender scale];
    }
    
    if ([sender state] == UIGestureRecognizerStateBegan ||
        [sender state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[sender view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (self.lastScale - [sender scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[sender view] transform], newScale, newScale);
        [sender view].transform = transform;
        
        self.lastScale = [sender scale];

    }


}




@end

