//
//  ADExamTextField.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/20.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADExamTextField.h"

#define kRightImageViewWidth 15
#define kRightImageViewHeight 18

@interface ADExamTextField()
@property (nonatomic, weak) UIImageView *rightImageView; // 对错

@end

@implementation ADExamTextField

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addRightImageView];
    }
    return self;
}

- (void)addRightImageView {
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - kRightImageViewWidth, CGRectGetHeight(self.frame) - kRightImageViewHeight, kRightImageViewWidth, kRightImageViewHeight)];
    rightImageView.contentMode = UIViewContentModeBottom;
    [self addSubview:rightImageView];
    _rightImageView = rightImageView;
    
}

-(void)setExamState:(ADExamTextFieldState)examState {
    _examState = examState;
    
    switch (examState) {
        case ADExamTextFieldStateNormal:
            self.userInteractionEnabled = YES;
            _rightImageView.image = nil;
            break;
            
        case ADExamTextFieldStateCorrect:
            self.userInteractionEnabled = NO;
            _rightImageView.image = [UIImage imageNamed:@"icon_zt_dui"];
            break;
            
        case ADExamTextFieldStateError:
            self.userInteractionEnabled = NO;
            _rightImageView.image = [UIImage imageNamed:@"icon_zt_cuo"];
            
        default:
            break;
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//空实现会对动画期间的性能产生负面影响。
- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画一条底部线
    CGContextSetRGBStrokeColor(context, 207.0/255, 207.0/255, 207.0/255, 1);//线条颜色
    CGContextMoveToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, rect.size.width,rect.size.height);
    CGContextStrokePath(context);
}


@end
