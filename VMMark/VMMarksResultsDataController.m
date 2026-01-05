//
//  VMMarksResultsDataController.m
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "VMMarksResultsDataController.h"
#import "VMMarksResults.h"
#import "utl_csvParser.h"


@interface VMMarksResultsDataController ()

- (void) initializeDefaultDataList;

@end


@implementation VMMarksResultsDataController


- (NSUInteger)countOfList {
    return [self.results count];
}




- (VMMarksResults *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.results objectAtIndex:theIndex];
}

- (void)addResult:(VMMarksResults *)result {
    [self.results addObject:result];
  
    
}

- (void)clearResults {
    [self.results removeAllObjects];
    
}

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void) initializeDefaultDataList  {
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    self.results = resultList;
 
}


- (void)loadResults:(NSString *)csvFile {
    if ([csvFile isEqualToString:@"Failed to Load"]) {  // failed to load. Let's pick the last version
        
    
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *issueURLsPlist = [documentsDirectory stringByAppendingPathComponent:@"results.dat"];
        
        self.results = [NSKeyedUnarchiver unarchiveObjectWithFile:issueURLsPlist];
        
        if (!self.results) {
            NSLog(@"There was an error loading myLibrary.dat");
        }
              
        
    } else {
        
        // load the data from the VWMark site
        CSVFile *ini = [[CSVFile alloc] initWithContentsOfString:csvFile];
      
        NSUInteger count = [ini count]-1;
        [self clearResults];
        for (NSUInteger i = 11; i < count; i+=11) {
            
            
            NSArray *s = [[ini objectAtIndex: i+3] componentsSeparatedByString:@"<br/>"];
            NSArray *r = [[ini objectAtIndex: i+2] componentsSeparatedByString:@" @ "];
            NSString *model = [s objectAtIndex:0];
            
            
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            [f setLocale:[NSLocale currentLocale]];
            [f setDecimalSeparator:@"."];
            
            NSNumber *bench = [f numberFromString:[r objectAtIndex:0]];
            NSNumber *sockets = [f numberFromString:[ini objectAtIndex: i+5]];
            
            
            NSMutableString *brand= [[NSMutableString alloc] initWithString:[ini objectAtIndex:i+1]];
            if ([brand isEqualToString:@"Hewlett-Packard"]) {
                brand = [[NSMutableString alloc] initWithString:@"HP"];
            }
            NSString *newBrand = [brand stringByAppendingString:@" "];

            NSString *newModel = [model stringByReplacingOccurrencesOfString:newBrand withString:@""];
            
            VMMarksResults *newItem = [[VMMarksResults alloc] initWithData:[ini objectAtIndex:i+1]
                                                                     Model:newModel
                                                               ResultBench:bench
                                                               ResultTiles:[r objectAtIndex:1]
                                                                    VMware:[s objectAtIndex:1]
                                                                   Version:[ini objectAtIndex: i+10]
                                                                     Hosts:[ini objectAtIndex: i+4]
                                                                   Sockets:sockets
                                                                     Cores:[ini objectAtIndex: i+6]
                                                                   Threads:[ini objectAtIndex: i+7]
                                                               matchedPair:[ini objectAtIndex: i+8]
                                                              uniformHosts:[ini objectAtIndex: i+9]
                                                                      date:[ini objectAtIndex: i]];
            [self addResult:newItem];
          
        }
       
        [self save];
    }
    
}

-(void) save {
    
  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *issueURLsPlist = [documentsDirectory stringByAppendingPathComponent:@"results.dat"];
    
      if (![NSKeyedArchiver archiveRootObject:self.results toFile:issueURLsPlist]) {
        NSLog(@"There was an error saving myLibrary.dat:");
    };
        
    
}


@end
