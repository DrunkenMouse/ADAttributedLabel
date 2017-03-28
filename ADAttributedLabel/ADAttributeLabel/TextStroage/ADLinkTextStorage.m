//
//  ADLinkTextStorage.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/12.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADLinkTextStorage.h"

@implementation ADLinkTextStorage
- (instancetype)init {
    if (self = [super init]) {
        self.underLineStyle = kCTUnderlineStyleSingle;
        self.modifier = kCTUnderlinePatternSolid;
    }
    return self;
}

#pragma mark - protocol
-(void)addTextStorageWithAttributedString:(NSMutableAttributedString *)attributedString {
    [super addTextStorageWithAttributedString:attributedString];
    [attributedString addAttribute:kADTextRunAttributedName value:self range:self.range];
    self.text = [attributedString.string substringWithRange:self.range];
}

@end
