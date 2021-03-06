//
//  ADTextContainer.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/12.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ADTextStorageProtocol.h"
#import "NSMutableAttributedString+AD.h"
#import "ADTextStorage.h"
#import "ADLinkTextStorage.h"
#import "ADDrawStorage.h"
#import "ADImageStorage.h"
#import "ADViewStorage.h"


@interface ADTextContainer : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSAttributedString *attributedText;
@property (nonatomic, assign) NSInteger numberOfLines; //行数
@property (nonatomic, strong) UIColor *textColor; //文字颜色

@property (nonatomic, strong) UIColor *linkColor; //链接颜色
@property (nonatomic, strong) UIFont *font; //文字大小
@property (nonatomic, assign) unichar strokeWidth; //空心字边框宽
@property (nonatomic, strong) UIColor *strokeColor;//空心字边框颜色
@property (nonatomic, assign) unichar characterSpacing;//字距
@property (nonatomic, assign) CGFloat linesSpacing; //行距
@property (nonatomic, assign) CGFloat paragraphSpacing;//段落间距
@property (nonatomic, assign) CTTextAlignment textAlignment;//文本对齐方式kCTTextAlignmentLeft
@property (nonatomic, assign) CTLineBreakMode lineBreakMode;// 换行模式 kCTLineBreakByCharWrapping
@property (nonatomic, assign) BOOL isWidthToFit; //宽度自适应
// after createTextContainer, have value
@property (nonatomic, assign, readonly) CGFloat textHeight;
@property (nonatomic, assign, readonly) CGFloat textWidth;
// after createTextContainer, have value
@property (nonatomic, strong, readonly) NSArray *textStorages;
/**
 *  生成文本容器textContainer
 */
- (instancetype)createTextContainerWithTextWidth:(CGFloat)textWidth;

-(instancetype)createTextContainerWithContentSize:(CGSize)contentSize;
/**
 *  生成属性字符串
 */
- (NSAttributedString *)createAttributedString;
/**
 *  获取文本的size
 */
- (CGSize)getSuggestedSizeWithFramesetter:(CTFramesetterRef)framesetter width:(CGFloat)width;
/**
 *  获取文本高度
 */
- (CGFloat)getHeightWithFramesetter:(CTFramesetterRef)framesetter width:(CGFloat)width;
@end

@interface ADTextContainer(Add)
/**
 *  添加 textStorage （自定义显示内容）
 *
 *  @param textStorage 自定义
 */
- (void)addTextStorage:(id<ADTextStorageProtocol>)textStorage;

/**
 *  添加 textRun数组 （自定义显示内容）
 *
 *  @param textStorageArray textRun数组（需遵循协议TYTextStorageProtocol,否则不会添加）
 */
- (void)addTextStorageArray:(NSArray *)textStorageArray;
@end

#pragma mark - append
@interface ADTextContainer(Append)
/**
 *  追加(添加到最后) 普通文本
 *
 *  @param text 普通文本
 */
- (void)appendText:(NSString *)text;
/**
 *  追加(添加到最后) 属性文本
 *
 *  @param attributedText 属性文本
 */
- (void)appendTextAttributedString:(NSAttributedString *)attributedText;
/**
 *  追加(添加到最后) textStorage （自定义显示内容）
 *
 *  @param textStorage 自定义Storage（自定义显示内容）
 */
- (void)appendTextStorage:(id<ADAppendTextStorageProtocol>)textStorage;
/**
 *  追加(添加到最后) textStorage 数组
 *
 *  @param textStorageArray 自定义run数组（需遵循协议TYAppendTextStorageProtocol,否则不会添加）
 */
- (void)appendTextStorageArray:(NSArray *)textStorageArray;

@end
#pragma mark - Link
@interface ADTextContainer(Link)
/**
 *  添加 链接LinkTextStorage
 */
- (void)addLinkWithLinkData:(id)linkData range:(NSRange)range;
/**
 *  添加 链接LinkTextStorage
 */
- (void)addLinkWithLinkData:(id)linkData linkColor:(UIColor *)linkColor range:(NSRange)range;
/**
 *  添加 链接LinkTextStorage
 *
 *  @param linkData         链接携带的数据
 *  @param linkColor        链接颜色
 *  @param underLineStyle   下划线样式（无，单 双) 默认单
 *  @param range            范围
 */
- (void)addLinkWithLinkData:(id)linkData linkColor:(UIColor *)linkColor  underLineStyle:(CTUnderlineStyle)underLineStyle range:(NSRange)range;
/**
 *  追加 链接LinkTextStorage
 */
- (void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkData:(id)linkData;
/**
 *  追加 链接LinkTextStorage
 */
-(void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkColor:(UIColor *)linkColor linkData:(id)linkData;
/**
 *  追加 链接LinkTextStorage
 *
 *  @param linkText         链接文本
 *  @param linkData         链接携带的数据
 *  @param underLineStyle   下划线样式（无，单 双) 默认单
 */
- (void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkColor:(UIColor *)linkColor underLineStyle:(CTUnderlineStyle)underLineStyle linkData:(id)linkData;
@end

#pragma mark - 扩展支持UIImage
@interface ADTextContainer(UIImage)

#pragma mark - addImageStorage
/**
 *  添加 imageStorage image数据
 */
- (void)addImage:(UIImage *)image range:(NSRange)range;

/**
 *  添加 imageStorage image数据
 */
- (void)addImage:(UIImage *)image range:(NSRange)range size:(CGSize)size;

/**
 *  添加 imageStorage image数据
 *
 *  @param image        image
 *  @param range        所在文本位置
 *  @param size         图片大小
 *  @param alignment    图片对齐方式
 */
- (void)addImage:(UIImage *)image range:(NSRange)range size:(CGSize)size alignment:(ADDrawAlignment)alignment;

/**
 *  添加 imageStorage image数据
 */
- (void)addimageWithName:(NSString *)imageName range:(NSRange)range;
/**
 *  添加 imageStorage image数据
 */
- (void)addimageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size;
/**
 *  添加 imageStorage image数据
 *
 *  @param imageName    image名
 *  @param range        所在文本位置
 *  @param size         图片大小
 *  @param alignment    图片对齐方式
 */
- (void)addimageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size alignment:(ADDrawAlignment)alignment;

#pragma mark - appendImageStorage
/**
 *  追加 imageStorage image数据
 */
- (void)appendImage:(UIImage *)image;
/**
 *  追加 imageStorage image数据
 */
- (void)appendImage:(UIImage *)image size:(CGSize)size;
/**
 *  追加 imageStorage image数据
 *
 *  @param image    image
 *  @param size         图片大小
 *  @param alignment    图片对齐
 */
- (void)appendImage:(UIImage *)image size:(CGSize)size alignment:(ADDrawAlignment)alignment;
/**
 *  追加 imageStorage image数据
 */
- (void)appendImageWithName:(NSString *)imageName;
/**
 *  追加 imageStorage image数据
 */
- (void)appendImageWithName:(NSString *)imageName size:(CGSize)size;
/**
 *  追加 imageStorage image数据
 *
 *  @param imageName    imageName
 *  @param size         图片大小
 *  @param alignment    图片对齐
 */
- (void)appendImageWithName:(NSString *)imageName size:(CGSize)size alignment:(ADDrawAlignment)alignment;
@end

#pragma mark - 扩展支持UIView

@interface ADTextContainer (UIView)
/**
 *  添加 viewStorage (添加 UI控件 需要设置frame)
 */
- (void)addView:(UIView *)view range:(NSRange)range;
/**
 *  添加 viewStorage (添加 UI控件 需要设置frame)
 *
 *  @param view         UIView (UI控件)
 *  @param range        所在文本位置
 *  @param alignment    view对齐方式
 */
-(void)addView:(UIView *)view range:(NSRange)range alignment:(ADDrawAlignment)alignment;
/**
 *  追加 viewStorage (添加 UI控件 需要设置frame)
 */
- (void)appendView:(UIView *)view;

/**
 *  追加 viewStorage (添加 UI控件 需要设置frame)
 *
 *  @param view  UIView (UI控件)
 *  @param alignment view对齐
 */
- (void)appendView:(UIView *)view alignment:(ADDrawAlignment)alignment;

@end




