//
//  EKOAttributedLabelCell.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOAttributedLabelCell.h"
#import "TTTAttributedLabel.h"
#import "EKOAttributedLabel.h"

@implementation EKOAttributedLabelCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.displayLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        self.displayLabel.numberOfLines = 0;
       // self.displayLabel.backgroundColor = [UIColor grayColor];
       // self.displayLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
       // self.displayLabel.suggestedTextLayoutSize = CGSizeZero;
        self.displayLabel.layer.borderColor = [UIColor redColor].CGColor;
        self.displayLabel.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.displayLabel];
    }
    return self;
}

-(void)awakeFromNib {
    
    
    [super awakeFromNib];
    self.displayLabel.numberOfLines = 0;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect rect = CGRectMake(20,0,200,CGRectGetHeight(self.contentView.frame));
    rect = CGRectIntegral(rect);
    rect.origin.y =1;
    
    self.displayLabel.frame =CGRectInset(rect,1,1);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
