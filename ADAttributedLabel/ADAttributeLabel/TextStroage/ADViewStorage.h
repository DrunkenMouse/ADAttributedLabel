//
//  ADViewStorage.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/12.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ADDrawStorage.h"

@interface ADViewStorage : ADDrawStorage <ADViewStorageProtocol>
@property (nonatomic, strong) UIView *view; // 添加View
@end
