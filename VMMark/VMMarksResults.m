//
//  VMMarksResults.m
//  VMMark
//
//  Created by epenedos on 3/4/13.
//  Copyright (c) 2013 epenedos. All rights reserved.
//

#import "VMMarksResults.h"

@implementation VMMarksResults


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
              date:(NSString *) date
{
    
    self = [super init];
    if (self) {

        _brandName = brandName;
        _brandModel = brandModel;
        _brandResultBench = brandResultBench;
        _brandResultTiles = brandResultTiles;
        _brandVMware = brandVMware;
        _vmmarkVersion = vmmarkVersion;
        _totalHosts = totalHosts;
        _totalSockets = totalSockets;
        _totalCores = totalCores;
        _totalThreads = totalThreads;
        _matchedPair = matchedPair;
        _uniformHosts = uniformHosts;
        _date = date;
        
        return self;
    }
    return nil;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.brandModel = [aDecoder decodeObjectForKey:@"brandModel"];
        self.brandName = [aDecoder decodeObjectForKey:@"brandName"];
        self.brandResultBench = [aDecoder decodeObjectForKey:@"brandResultBench"];
        self.brandResultTiles = [aDecoder decodeObjectForKey:@"brandResultTiles"];
        self.brandVMware = [aDecoder decodeObjectForKey:@"brandVMware"];
        self.vmmarkVersion = [aDecoder decodeObjectForKey:@"vmmarkVersion"];
        self.totalHosts = [aDecoder decodeObjectForKey:@"totalHosts"];
        self.totalSockets = [aDecoder decodeObjectForKey:@"totalSockets"];
        self.totalCores = [aDecoder decodeObjectForKey:@"totalCores"];
        self.totalThreads = [aDecoder decodeObjectForKey:@"totalThreads"];
        self.matchedPair = [aDecoder decodeObjectForKey:@"matchedPair"];
        self.uniformHosts = [aDecoder decodeObjectForKey:@"uniformHosts"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_brandModel forKey:@"brandModel"];
    [aCoder encodeObject:_brandName forKey:@"brandName"];
    [aCoder encodeObject:_brandResultBench forKey:@"brandResultBench"];
    [aCoder encodeObject:_brandResultTiles forKey:@"brandResultTiles"];
    [aCoder encodeObject:_brandVMware forKey:@"brandVMware"];
    [aCoder encodeObject:_vmmarkVersion forKey:@"vmmarkVersion"];
    [aCoder encodeObject:_totalHosts forKey:@"totalHosts"];
    [aCoder encodeObject:_totalSockets forKey:@"totalSockets"];
    [aCoder encodeObject:_totalCores forKey:@"totalCores"];
    [aCoder encodeObject:_totalThreads forKey:@"totalThreads"];
    [aCoder encodeObject:_matchedPair forKey:@"matchedPair"];
    [aCoder encodeObject:_uniformHosts forKey:@"uniformHosts"];
    [aCoder encodeObject:_date forKey:@"date"];
}



@end
