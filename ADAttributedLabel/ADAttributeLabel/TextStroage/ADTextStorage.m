//
//  ADTextStorage.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/12.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADTextStorage.h"
#import "NSMutableAttributedString+AD.h"

#pragma mark - protocol



@implementation ADTextStorage

- (void)addTextStorageWithAttributedString:(NSMutableAttributedString *)attributedString {
    //颜色
    if (_textColor) {
        [attributedString addAttributeTextColor:_textColor range:_range];
    }
    //字体
    if (_font) {
        [attributedString addAttributeFont:_font range:_range];
    }
    //下划线
    if (_underLineStyle) {
        [attributedString addAttributeUnderlineStyle:_underLineStyle modifier:_modifier range:_range];
    }
}

- (NSAttributedString *)appendTextStorageAttributedString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_text];
    
    //验证范围
    if (NSEqualRanges(_range, NSMakeRange(0, 0))) {
        _range = NSMakeRange(0, attributedString.length);
    }
    [self addTextStorageWithAttributedString:attributedString];
    return [attributedString copy];
}



@end
