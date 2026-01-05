//
//  VMMarksResults.h
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VMMarksResults : NSObject <NSCoding>
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *brandModel;
@property (nonatomic, copy) NSNumber *brandResultBench;
@property (nonatomic, copy) NSString *brandResultTiles;
@property (nonatomic, copy) NSString *brandVMware;
@property (nonatomic, copy) NSString *vmmarkVersion;
@property (nonatomic, copy) NSString *totalHosts;
@property (nonatomic, copy) NSNumber *totalSockets;
@property (nonatomic, copy) NSString *totalCores;
@property (nonatomic, copy) NSString *totalThreads;
@property (nonatomic, copy) NSString *matchedPair;
@property (nonatomic, copy) NSString *uniformHosts;
@property (nonatomic, copy) NSString *date;

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id) initWithData:(NSString *)brandName
             Model:(NSString *)brandModel
            ResultBench:(NSNumber *)brandResultBench
            ResultTiles:(NSString *)brandResultTiles
            VMware:(NSString *)brandVMware
           Version:(NSString *)vmmarkVersion
             Hosts:(NSString *)totalHosts
           Sockets:(NSNumber *)totalSockets
             Cores:(NSString *)totalCores
           Threads:(NSString *)totalThreads
       matchedPair:(NSString *)matchedPair
      uniformHosts:(NSString *)uniformHosts
              date:(NSString *) date;

@end
