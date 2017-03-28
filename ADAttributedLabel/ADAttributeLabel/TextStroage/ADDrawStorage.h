//
//  ADDrawStorage.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/11.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>
#import "ADTextStorageProtocol.h"

@interface ADDrawStorage : NSObject<ADDrawStorageProtocol>

@property (nonatomic, assign) NSInteger tag;  // 标识
@property (nonatomic, assign) NSRange   range;          // 文本范围
@property (nonatomic, assign) NSRange   realRange;
@property (nonatomic, assign) UIEdgeInsets  margin;         // 图片四周间距
@property (nonatomic, assign) CGSize    size;           // 绘画物大小
@property (nonatomic, assign) ADDrawAlignment drawAlignment;  // 对齐方式
/**
 *  获取绘画区域上行高度(默认实现)
 */
- (CGFloat)getDrawRunAscentHeight;

/**
 *  获取绘画区域下行高度 默认实现为0（一般不需要改写）
 */
- (CGFloat)getDrawRunDescentHeight;

/**
 *  获取绘画区域宽度（默认实现）
 */
- (CGFloat)getDrawRunWidth;

/**
 *  释放内存 （一般不需要 已注释 需要在打开）
 */
//- (void)DrawRunDealloc;
@end
