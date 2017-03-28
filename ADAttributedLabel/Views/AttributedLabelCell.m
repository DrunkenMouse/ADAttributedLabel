//
//  AttributedLabelCell.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/2/7.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "AttributedLabelCell.h"

@interface ADAttributedLabel()
@property (nonatomic, weak)ADAttributedLabel *label;

@end

@implementation AttributedLabelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addAtrribuedLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addAtrribuedLabel];
    }
    return self;
}

- (void)addAtrribuedLabel
{
    ADAttributedLabel *label = [[ADAttributedLabel alloc]init];
    label.highlightedLinkColor = [UIColor redColor];
    [self addSubview:label];
    _label = label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_label setFrameWithOrigin:CGPointMake(0, 15) Width:CGRectGetWidth(self.frame)];
    // or this use
    //_label.frame = CGRectMake(0, 15, CGRectGetWidth(self.frame), 0);
    //[_label sizeToFit];
    
}
@end
