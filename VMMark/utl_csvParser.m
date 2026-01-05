//
//  utl_csvParser.m
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "utl_csvParser.h"

@implementation CSVFile

- (id)initWithContentsOfString:(NSString *)s
{
    if ((self = [super init])) {
//        self.data = [s componentsSeparatedByString:@","];
        self.data = [s componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@",\n"]];
     
    }
    return self;
}

- (id)initWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc
{
    return [self initWithContentsOfString:[NSString stringWithContentsOfURL:url encoding:enc error:NULL]];
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> (data = %@)", [self class], self, [self.data componentsJoinedByString:@","]];
}

- (NSString *)objectAtIndex:(unsigned int)i
{
    return self.data ? [self.data objectAtIndex:i] : nil;
}

- (unsigned int)count
{
    return self.data ? [self.data count] : 0U;
}

@end