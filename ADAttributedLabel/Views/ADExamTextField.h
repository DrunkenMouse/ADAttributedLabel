//
//  ADExamTextField.h
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/20.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ADExamTextFieldState) {
    ADExamTextFieldStateNormal,
    ADExamTextFieldStateCorrect,
    ADExamTextFieldStateError,
};

@interface ADExamTextField : UITextField

@property(nonatomic, assign) ADExamTextFieldState examState;

@end
