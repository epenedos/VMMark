//
//  utl_csvParser.h
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CSVFile : NSObject

@property (strong, nonatomic) NSArray *data;


- (id)initWithContentsOfString:(NSString *)s;
- (id)initWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc;
- (NSString *)objectAtIndex:(unsigned int)i;
- (unsigned int)count;

@end