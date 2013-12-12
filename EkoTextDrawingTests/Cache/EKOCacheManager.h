//
//  EKOCacheManager.h
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/12/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKOCacheManager : NSObject

+(EKOCacheManager *)sharedManager;


@property(readonly,nonatomic)NSCache *viewsCache;


@end
