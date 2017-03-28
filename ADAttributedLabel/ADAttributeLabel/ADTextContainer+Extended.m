//
//  ADTextContainer+Extended.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/16.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADTextContainer.h"

@implementation ADTextContainer (Link)

#pragma mark - addLink
-(void)addLinkWithLinkData:(id)linkData range:(NSRange)range {
 
    [self addLinkWithLinkData:linkData linkColor:nil range:range];
}

-(void)addLinkWithLinkData:(id)linkData linkColor:(UIColor *)linkColor range:(NSRange)range {
    
    [self addLinkWithLinkData:linkData linkColor:linkColor underLineStyle:kCTUnderlineStyleSingle range:range];
}


-(void)addLinkWithLinkData:(id)linkData linkColor:(UIColor *)linkColor underLineStyle:(CTUnderlineStyle)underLineStyle range:(NSRange)range {
    
    ADLinkTextStorage *linkTextStorage = [[ADLinkTextStorage alloc] init];
    linkTextStorage.range = range;
    linkTextStorage.textColor = linkColor;
    linkTextStorage.linkData = linkData;
    linkTextStorage.underLineStyle = underLineStyle;
    [self addTextStorage:linkTextStorage];
}

#pragma mark - appendLink
-(void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkData:(id)linkData {
    
    [self appendLinkWithText:linkText linkFont:linkFont linkColor:nil  linkData:linkData];
}

-(void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkColor:(UIColor *)linkColor linkData:(id)linkData {
   
    [self appendLinkWithText:linkText linkFont:linkFont linkColor:linkColor underLineStyle:kCTUnderlineStyleSingle linkData:linkData];
}

-(void)appendLinkWithText:(NSString *)linkText linkFont:(UIFont *)linkFont linkColor:(UIColor *)linkColor underLineStyle:(CTUnderlineStyle)underLineStyle linkData:(id)linkData {
    
    ADLinkTextStorage *linkTextStorage = [[ADLinkTextStorage alloc] init];
    linkTextStorage.text = linkText;
    linkTextStorage.font = linkFont;
    linkTextStorage.textColor = linkColor;
    linkTextStorage.linkData = linkData;
    linkTextStorage.underLineStyle = underLineStyle;
    [self appendTextStorage:linkTextStorage];
}

@end

@implementation ADTextContainer (UIImage)

#pragma mark addImage
- (void)addImageContent:(id)imageContent range:(NSRange)range size:(CGSize)size alignment:(ADDrawAlignment)alignment
{
    
    ADImageStorage *imageStorage = [[ADImageStorage alloc] init];
    if ([imageContent isKindOfClass:[UIImage class]]) {
        imageStorage.image = imageContent;
    }else if([imageContent isKindOfClass:[NSString class]]) {
        imageStorage.imageName = imageContent;
    }else  {
        return;
    }
    
    imageStorage.drawAlignment = alignment;
    imageStorage.range = range;
    imageStorage.size = size;
    [self addTextStorage:imageStorage];
}

- (void)addImage:(UIImage *)image range:(NSRange)range size:(CGSize)size alignment:(ADDrawAlignment)alignment {
    
    [self addImageContent:image range:range size:size alignment:alignment];
}

-(void)addImage:(UIImage *)image range:(NSRange)range size:(CGSize)size {
    
    [self addImage:image range:range size:size alignment:ADDrawAlignmentTop];
}

-(void)addImage:(UIImage *)image range:(NSRange)range {
    
    [self addImage:image range:range size:image.size];
}

-(void)addimageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size alignment:(ADDrawAlignment)alignment {
    
    [self addImageContent:imageName range:range size:size alignment:alignment];
}

- (void)addimageWithName:(NSString *)imageName range:(NSRange)range size:(CGSize)size {
    
    [self addimageWithName:imageName range:range size:size alignment:ADDrawAlignmentTop];
}

-(void)addimageWithName:(NSString *)imageName range:(NSRange)range {
    
    [self addimageWithName:imageName range:range size:CGSizeMake(self.font.pointSize, self.font.ascender)];
}
#pragma mark - appendImage

- (void)appendImageContent:(id)imageContent size:(CGSize)size alignment:(ADDrawAlignment)alignment
{
    ADImageStorage  *imageStorage = [[ADImageStorage alloc] init];
    if ([imageContent isKindOfClass:[UIImage class]]) {
        imageStorage.image = imageContent;
    }else if ([imageContent isKindOfClass:[NSString class]]) {
        imageStorage.imageName = imageContent;
    }else {
        return;
    }
    
    imageStorage.drawAlignment = alignment;
    imageStorage.size = size;
    [self appendTextStorage:imageStorage];
}

-(void)appendImage:(UIImage *)image size:(CGSize)size alignment:(ADDrawAlignment)alignment {
    
    [self appendImageContent:image size:size alignment:alignment];
}

-(void)appendImage:(UIImage *)image size:(CGSize)size {
   
    [self appendImage:image size:size alignment:ADDrawAlignmentTop];
}

-(void)appendImage:(UIImage *)image {
    
    [self appendImage:image size:image.size];
}

-(void)appendImageWithName:(NSString *)imageName size:(CGSize)size alignment:(ADDrawAlignment)alignment {
    
    [self appendImageContent:imageName size:size alignment:alignment];
}

-(void)appendImageWithName:(NSString *)imageName size:(CGSize)size {
    
    [self appendImageContent:imageName size:size alignment:ADDrawAlignmentTop];
}

-(void)appendImageWithName:(NSString *)imageName {
    
    [self appendImageWithName:imageName size:CGSizeMake(self.font.pointSize, self.font.ascender)];
}

@end

@implementation ADTextContainer (UIView)
#pragma mark - addView

- (void)addView:(UIView *)view range:(NSRange)range alignment:(ADDrawAlignment)alignment
{
    ADViewStorage *viewStorage = [[ADViewStorage alloc] init];
    viewStorage.drawAlignment = alignment;
    viewStorage.view = view;
    viewStorage.range = range;
    
    [self addTextStorage:viewStorage];
}

-(void)addView:(UIView *)view range:(NSRange)range {
    
    [self addView:view range:range alignment:ADDrawAlignmentTop];
}

#pragma mark - appendView
-(void)appendView:(UIView *)view alignment:(ADDrawAlignment)alignment {
    
    ADViewStorage *viewStorage = [[ADViewStorage alloc] init];
    viewStorage.drawAlignment = alignment;
    viewStorage.view = view;
    
    [self appendTextStorage:viewStorage];
}

-(void)appendView:(UIView *)view {
    
    [self appendView:view alignment:ADDrawAlignmentTop];
}

@end
