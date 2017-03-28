//
//  ImageTextViewController.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/17.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ImageTextViewController.h"
#import "ADAttributedLabel.h"
#import "RegexKitLite.h"

#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ImageTextViewController ()<ADAttributedLabelDelegate>
@property (nonatomic,weak) ADAttributedLabel *label1;
@property (nonatomic,weak) ADAttributedLabel *label2;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ImageTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    [self addScrollView];
    
    // appendAttributedText
    [self addTextAttributedLabel1];
    
    // addAttributedText
    [self addTextAttributedLabel2];
    
}

- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

// appendAttributedText
- (void)addTextAttributedLabel1
{
    ADAttributedLabel *label = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    label.delegate = self;
    [_scrollView addSubview:label];
    _label1 = label;
    
    NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过程会很痛，会很辛苦，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。\n\t我们都将孤独地长大，不要害怕。";
    
    // 分割文本到数组
    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
    
    NSInteger index = 0;
    
    // 追加 图片Url
    ADImageStorage *imageUrlStorage = [[ADImageStorage alloc]init];
    imageUrlStorage.imageURL = [NSURL URLWithString:@"http://imgbdb2.bendibao.com/beijing/201310/21/2013102114858726.jpg"];
    imageUrlStorage.size = CGSizeMake(CGRectGetWidth(label.frame), 343*CGRectGetWidth(label.frame)/600);
    [label appendTextStorage:imageUrlStorage];
    
    for (NSString *text in textArray) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
        
        if (index != 4) {
            // 添加属性
            [attributedString addAttributeTextColor:colorArray[index%5]];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:15+arc4random()%4]];
            
            // 追加(添加到最后)文本
            [label appendTextAttributedString:attributedString];
            [label appendImageWithName:@"haha"];
            [label appendText:@"\n\t"];
        } else {
            [label appendImageWithName:@"avatar" size:CGSizeMake(60, 60)];
            [label appendText:text];
        }
        index++;
    }
    //两种方法 [label appendImageWithName:@"avatar" size:CGSizeMake(60, 60)];
    ADImageStorage *imageStorage = [[ADImageStorage alloc]init];
    imageStorage.imageName = @"haha";
    imageStorage.size = CGSizeMake(15, 15);
    [label appendTextStorage:imageStorage];

    [label appendText:@"image左对齐"];
    ADImageStorage *imageStorageAlignLeft = [[ADImageStorage alloc]init];
    imageStorageAlignLeft.imageName = @"CYLoLi";
    imageStorageAlignLeft.imageAlignment = ADImageAlignmentLeft;
    imageStorageAlignLeft.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    [label appendTextStorage:imageStorageAlignLeft];

    [label appendText:@"image居中对齐"];
    ADImageStorage *imageStorageAlignCenter = [[ADImageStorage alloc]init];
    imageStorageAlignCenter.imageName = @"CYLoLi";
    imageStorageAlignCenter.imageAlignment = ADImageAlignmentCenter;
    imageStorageAlignCenter.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    [label appendTextStorage:imageStorageAlignCenter];

    [label appendText:@"image右对齐"];
    ADImageStorage *imageStorageAlignRight = [[ADImageStorage alloc]init];
    imageStorageAlignRight.imageName = @"CYLoLi";
    imageStorageAlignRight.imageAlignment = ADImageAlignmentRight;
    imageStorageAlignRight.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    [label appendTextStorage:imageStorageAlignRight];

    [label appendText:@"image铺满"];
    ADImageStorage *imageStorageAlignFill = [[ADImageStorage alloc]init];
    imageStorageAlignFill.imageName = @"CYLoLi";
    imageStorageAlignFill.imageAlignment = ADImageAlignmentFill;
    imageStorageAlignFill.size = CGSizeMake(CGRectGetWidth(self.view.frame), 100);
    [label appendTextStorage:imageStorageAlignFill];

    [label sizeToFit];
}

// addAttributedText
- (void)addTextAttributedLabel2
{
    //使用 RegexKitLite，添加 -fno-objc-arc，同时添加 libicucore.dylib
    //其实所有漂泊的人，不过是为了有一天能够不再漂泊，能用自己的力量撑起身后的家人和自己爱的人。
    ADAttributedLabel *label = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_label1.frame) + 20, CGRectGetWidth(self.view.frame), 0)];
    [_scrollView addSubview:label];
    label.delegate = self;
    NSString *text = [NSString stringWithFormat:@"[CYLoLi,%d,180]其实所有漂泊的人，[haha,15,15]不过是为了有一天能够不再[CYLoLi,%d,90]漂泊，[haha,15,15]能用自己的力量撑起身后的家人和自己爱的人。[avatar,60,60]",(int)CGRectGetWidth(self.view.frame),(int)CGRectGetWidth(self.view.frame)/2];
    
    // 属性文本生成器
    ADTextContainer *attStringCreater = [[ADTextContainer alloc]init];
    attStringCreater.text = text;
    NSMutableArray *tmpArray = [NSMutableArray array];

    // 正则匹配图片信息
    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        //captureCount 特殊字符串的个数
        //capturedStrings 特殊字符串
        //capturedRanges 特殊字符串的range
        
        if (captureCount > 3) {
            // 图片信息储存
            ADImageStorage *imageStorage = [[ADImageStorage alloc]init];
            imageStorage.imageName = capturedStrings[1];
            imageStorage.range = capturedRanges[0];
            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
            [tmpArray addObject:imageStorage];
            
            NSLog(@"capturedRanges.length = %ld,capturedRanges[0].location = %ld,capturedStrings[1]= %@,capturedStrings[2]= %@,capturedStrings[2]= %@",capturedRanges[0].length,capturedRanges[0].location,capturedStrings[1],capturedStrings[2],capturedStrings[3]);
        }
    }];

    // 添加图片信息数组到label
    [attStringCreater addTextStorageArray:tmpArray];

    ADTextStorage *textStorage = [[ADTextStorage alloc]init];
    textStorage.range = [text rangeOfString:@"[CYLoLi,320,180]其实所有漂泊的人，"];
    textStorage.textColor = RGB(213, 0, 0, 1);
    textStorage.font = [UIFont systemFontOfSize:16];
    [attStringCreater addTextStorage:textStorage];

    textStorage = [[ADTextStorage alloc]init];
    textStorage.range = [text rangeOfString:@"不过是为了有一天能够不再漂泊，"];
    textStorage.textColor = RGB(0, 155, 0, 1);
    textStorage.font = [UIFont systemFontOfSize:18];
    [attStringCreater addTextStorage:textStorage];

    [attStringCreater createTextContainerWithTextWidth:CGRectGetWidth(self.view.frame)];

    [label setTextContainer:attStringCreater];

    [label sizeToFit];

    _label2 = label;

    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(label.frame)+10)];
}

#pragma mark - deleagte

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageClicked:(id<ADTextStorageProtocol>)textStorage atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
}

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageLongPressed:(id<ADTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"textStorageLongPressed");
}


@end
