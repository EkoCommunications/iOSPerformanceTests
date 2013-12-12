//
//  EKOTextDisplayCell.m
//  EkoTextDrawingTests
//
//  Created by Steven Grace on 12/11/13.
//  Copyright (c) 2013 Steven Grace. All rights reserved.
//

#import "EKOTextDisplayCell.h"

@implementation EKOTextDisplayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)prepareForReuse {
    
    [super prepareForReuse];
    self.displayLabel.text = nil;
    
}
-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.displayLabel.frame = CGRectMake(CGRectGetMinX(self.displayLabel.frame),0,200,CGRectGetHeight(self.contentView.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
