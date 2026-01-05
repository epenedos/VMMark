//
//  VMMarksResultsDataController.h
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VMMarksResults;
@interface VMMarksResultsDataController : NSObject

@property (nonatomic,retain) NSMutableArray *results;


- (NSUInteger) countOfList;

-(VMMarksResults *)objectInListAtIndex:(NSUInteger)theIndex;
-(void) addResult:(VMMarksResults *) result;
-(void)clearResults;
-(void)save;

-(void)loadResults:(NSString* ) csvFile;


@end
