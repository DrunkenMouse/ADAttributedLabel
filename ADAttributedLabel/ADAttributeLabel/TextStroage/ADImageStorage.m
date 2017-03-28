//
//  ADImageStorage.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/11.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADImageStorage.h"
#import "ADImageCache.h"

@interface ADImageStorage()
@property (nonatomic, weak) UIView *ownerView;
@property (nonatomic, assign) BOOL isNeedUpdateFrame;

@end

@implementation ADImageStorage
-(instancetype)init {
    if (self = [super init]) {
        _cacheImageOnMemory = NO;
    }
    return self;
}

#pragma mark - protocol
-(void)setOwnerView:(UIView *)ownerView {
    _ownerView = ownerView;
    if (!ownerView || !_imageURL) {
        return;
    }
    if ([_imageURL isKindOfClass:[NSURL class]] && ![[ADImageCache cache]imageIsCacheForURL:_imageURL.absoluteString]) {
        [[ADImageCache cache] saveAsyncImageFromURL:_imageURL.absoluteString thumbImageSize:self.size completion:^(BOOL isCache) {
            if (_isNeedUpdateFrame) {
                if (ownerView && isCache) {
                    [ownerView setNeedsDisplay];
                }
                _isNeedUpdateFrame = NO;
            }
        }];
    }
}

-(void)drawStorageWithRect:(CGRect)rect {
    __block UIImage *image = nil;
    if (_image) {
        //本地图片名
        image = _image;
    }else if (_imageName) {
        //图片网址
        image = [UIImage imageNamed:_imageName];
        if (_cacheImageOnMemory) {
            _image = image;
        }
    } else if (_imageURL) {
        //图片数据
        [[ADImageCache cache] imageForURL:_imageURL.absoluteString needThumImage:NO found:^(UIImage *loaceImage) {
            image = loaceImage;
            if (_cacheImageOnMemory) {
                _image = image;
            }
        } notFound:^{
            image = _placeholdImageName ? [UIImage imageNamed:_placeholdImageName] :nil;
            _isNeedUpdateFrame = YES;
        }];
    }
  
    if (image) {
        CGRect fitRect = [self rectFitOriginSize:image.size byRect:rect];
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, fitRect, image.CGImage);
    }
    

}

- (CGRect)rectFitOriginSize:(CGSize)size byRect:(CGRect)byRect {
    if (_imageAlignment == ADImageAlignmentFill) {
        return byRect;
    }
    CGRect scaleRect = byRect;
    CGFloat targetWdith = byRect.size.width;
    CGFloat targetHegiht = byRect.size.height;
    CGFloat widthFactor = targetWdith / size.width;
    CGFloat heightFactor = targetHegiht / size.height;
    CGFloat scaleFactor = MIN(widthFactor, heightFactor);
    CGFloat scaledWidth = size.width * scaleFactor;
    CGFloat scaledHeight = size.height * scaleFactor;
    scaleRect.size = CGSizeMake(scaledWidth, scaledHeight);
    // center the image
    if (widthFactor < heightFactor) {
        scaleRect.origin.y += (targetHegiht - scaledHeight) * 0.5;
    }else if (widthFactor > heightFactor) {
        switch (_imageAlignment) {
            case ADImageAlignmentCenter:
                scaleRect.origin.x += (targetWdith - scaledWidth) *0.5;
                break;
            case ADImageAlignmentRight:
                scaleRect.origin.x += (targetWdith - scaledWidth);
                
            default:
                break;
        }
    }
    return scaleRect;
}

// override
- (void)didNotDrawRun
{
    
}
@end
