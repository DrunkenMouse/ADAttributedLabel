//
//  ADImageStorage.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/11.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADDrawStorage.h"

typedef enum : NSUInteger {
    ADImageAlignmentCenter, //图片居中
    ADImageAlignmentLeft,   //图片左对齐
    ADImageAlignmentRight,  //图片右对齐
    ADImageAlignmentFill    //图片拉伸填充
} ADImageAlignment;

@interface ADImageStorage : ADDrawStorage <ADViewStorageProtocol>


@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSString *placeholdImageName;

@property (nonatomic, assign) ADImageAlignment imageAlignment;//default left
@property (nonatomic, assign) BOOL cacheImageOnMemory;// default NO ,if YES can improve performance，but increase memory


@end
