//
//  EKOAttributedTextHeightOperation.h
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKOAttributedTextHeightOperation : NSOperation

-(instancetype)initWithAttributedString:(NSAttributedString *)string andSize:(CGSize)aSize;

@property(copy,nonatomic)NSIndexPath *contextIndexPath;

@property(nonatomic,readonly)CGFloat calculatedHeight;

@end
