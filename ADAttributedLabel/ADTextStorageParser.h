//
//  ADTextStorageParser.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/2/13.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADTextStorageParser : NSObject

+ (NSArray *)parseWithJsonFilePath:(NSString *)filePath;

+ (NSArray *)parseWithJsonData:(NSData *)jsonData;

+ (NSArray *)parseWithJsonArray:(NSArray *)jsonArray;

@end
