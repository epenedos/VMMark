//
//  WebRequest.m
//  teste
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "WebRequest.h"
#import "utl_csvParser.h"

@implementation WebRequest


+(void)requestPath:(NSString *)path onCompletion:(RequestCompletionHandler)complete
{
    // Background Queue
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    
    // URL Request
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]
                                                  cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                              timeoutInterval:10];
    
    // Send Request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               if (complete) complete(result,error);
                           }];
}


@end
