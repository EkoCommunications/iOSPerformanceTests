//
//  EKOAttributedTextHeightOperation.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOAttributedTextHeightOperation.h"

@interface EKOAttributedTextHeightOperation ()

@property(nonatomic,readwrite,assign)CGFloat calculatedHeight;

@end

@implementation EKOAttributedTextHeightOperation{
    
    NSAttributedString *attributedString;
    CGSize size;
    
    
}

-(instancetype)initWithAttributedString:(NSAttributedString *)string andSize:(CGSize)aSize{
    
    self = [super init];
    if(self){
        size = aSize;
        attributedString = string;
    }
    return self;
    
}
-(void)main{
    
    
    if(!attributedString)
        return;


    NSTextContainer * textContainer = [[NSTextContainer alloc]initWithSize:size];
    
    NSTextStorage *textStorage =[[NSTextStorage alloc]initWithAttributedString:attributedString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc]init];
    [textStorage addLayoutManager:layoutManager];
    
    [layoutManager addTextContainer:textContainer];
    
    NSRange range  = NSMakeRange(0,[attributedString.string length]);
    [layoutManager ensureLayoutForCharacterRange:range];
    

    CGRect rect = [layoutManager boundingRectForGlyphRange:range inTextContainer:textContainer];
    
    self.calculatedHeight =  CGRectIntegral(rect).size.height;
    
    /// self.calculatedHeight =
   // [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    
}

@end
