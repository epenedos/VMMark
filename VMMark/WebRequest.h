//
//  WebRequest.h
//  teste
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^RequestCompletionHandler)(NSString*,NSError*);

@interface WebRequest : NSObject
+(void)requestPath:(NSString *)path
      onCompletion:(RequestCompletionHandler)complete;



@end
