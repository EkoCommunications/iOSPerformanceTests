//
//  EKOAttributedLabel.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/12/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOAttributedLabel.h"

@implementation EKOAttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Atempted to override these functions and provide a predetermined size for save calls
// to CoreText for Suggested Text Frame size

/*
- (CGSize)sizeThatFits:(CGSize)size{
    
    if(CGSizeEqualToSize(self.suggestedTextLayoutSize,CGSizeZero)==YES)
        return [super sizeThatFits:size];
    
    return self.suggestedTextLayoutSize;
    
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    
    if(CGSizeEqualToSize(self.suggestedTextLayoutSize,CGSizeZero)==YES)
        return [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    return CGRectMake(0,0,self.suggestedTextLayoutSize.width,self.suggestedTextLayoutSize.height);
}
*/


@end
