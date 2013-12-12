//
//  EKOCacheManager.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/12/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOCacheManager.h"

@implementation EKOCacheManager {
    
    NSCache *viewsCache;
    
    
}


+(EKOCacheManager *)sharedManager {
    
    static id instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
    
}

#pragma mark - Getters (Lazy Init)

-(NSCache *)viewsCache {
    
    if(viewsCache)
        return viewsCache;
    
    viewsCache = [[NSCache alloc]init];
    return viewsCache;
    
}



@end
