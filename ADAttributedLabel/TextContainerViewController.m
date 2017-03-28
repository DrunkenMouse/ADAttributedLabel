//
//  TextContainerViewController.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/17.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "TextContainerViewController.h"

#import "ADAttributedLabel.h"
#import "RegexKitLite.h"
#import "ADExamTextField.h"
#import "TPKeyboardAvoidingScrollView.h"

#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kExamTextFieldWidth 80
#define kExamTextFieldHeight 30
#define kAttrLabelWidth (CGRectGetWidth(self.view.frame)-20)
#define kTextFieldTag 1000

@interface TextContainerViewController ()<ADAttributedLabelDelegate>
@property (nonatomic,strong) ADAttributedLabel *label;
@property (nonatomic,strong) ADTextContainer *textContainer;
@property (nonatomic,strong) NSAttributedString *attString;
@property (nonatomic,weak) TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic,strong) NSArray *answerArray;
@end

@implementation TextContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _answerArray = @[@"白露为霜",@"所谓伊人",@"道阻且跻",@"蒹葭采采",@"白露未已",@"宛在水中沚",@"企慕"];
    [self createTextContainer];

    [self addScrollView];

    [self addTextAttributedLabel];

    [self addSubmitAnswerBtn];
}

- (void)addScrollView
{
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}

- (void)createTextContainer
{
    NSString *text = @"<img>蒹葭-云歌\n蒹葭苍苍，[@]。所谓伊人，在水一方。溯洄从之，道阻且长，溯游从之，宛在水中央。\n蒹葭萋萋，白露未晞。[@]，在水之湄。溯洄从之，[@]。溯游从之，宛在水中坻。\n[@]，[@]。所谓伊人，在水之涘。溯洄从之，道阻且右。溯游从之，[@]。\n注解:\n《蒹葭》，[haha]出自《诗经·国风·秦风》，是一首描写对意中人深深的[@]和求而不得的惆怅的诗。\n";

    // 属性文本生成器
    ADTextContainer *textContainer = [[ADTextContainer alloc]init];
    textContainer.text = text;

    // 整体设置属性
    textContainer.linesSpacing = 2;
    textContainer.paragraphSpacing = 5;

    // 文字样式
    ADTextStorage *textStorage = [[ADTextStorage alloc]init];
    textStorage.range = [text rangeOfString:@"蒹葭"];
    textStorage.font = [UIFont systemFontOfSize:18];
    textStorage.textColor = RGB(206, 39, 206, 1);
    [textContainer addTextStorage:textStorage];

    // 文字样式
    ADTextStorage *textStorage1 = [[ADTextStorage alloc]init];
    textStorage1.range = [text rangeOfString:@"注解:"];
    textStorage1.font = [UIFont systemFontOfSize:17];
    textStorage1.textColor = RGB(209, 162, 74, 1);
    [textContainer addTextStorage:textStorage1];

    // 下划线文字
    ADLinkTextStorage *linkTextStorage = [[ADLinkTextStorage alloc]init];
    linkTextStorage.range = [text rangeOfString:@"《蒹葭》"];
    linkTextStorage.linkData = @"点击了 《蒹葭》";
    [textContainer addTextStorage:linkTextStorage];

    ADLinkTextStorage *linkTextStorage1 = [[ADLinkTextStorage alloc]init];
    linkTextStorage1.range = [text rangeOfString:@"《诗经·国风·秦风》"];
    linkTextStorage1.linkData = @"点击了 《诗经·国风·秦风》";
    [textContainer addTextStorage:linkTextStorage1];

    // url图片
    ADImageStorage *imageUrlStorage = [[ADImageStorage alloc]init];
    imageUrlStorage.range = [text rangeOfString:@"<img>"];
    imageUrlStorage.imageURL = [NSURL URLWithString:@"http://imgbdb2.bendibao.com/beijing/201310/21/2013102114858726.jpg"];
    imageUrlStorage.size = CGSizeMake(kAttrLabelWidth, 343*kAttrLabelWidth/600);
    [textContainer addTextStorage:imageUrlStorage];

    // image图片
    ADImageStorage *imageStorage = [[ADImageStorage alloc]init];
    imageStorage.range = [text rangeOfString:@"[haha]"];
    imageStorage.imageName = @"haha";
    imageStorage.size = CGSizeMake(15, 15);
    [textContainer addTextStorage:imageStorage];

    // 填空题
    NSArray *blankStorage = [self.class parseTextFieldsWithString:text];
   
    [textContainer addTextStorageArray:blankStorage];

    // 生成 NSAttributedString
//    _attString = [textContainer createAttributedString];

    // 或者 生成 TYTextContainer
    _textContainer = [textContainer createTextContainerWithTextWidth:kAttrLabelWidth];
    
}

// 解析填空
+ (NSArray *)parseTextFieldsWithString:(NSString *)string
{
    NSMutableArray *textFieldArray = [NSMutableArray array];
    [string enumerateStringsMatchedByRegex:@"\\[@\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {

        if (captureCount > 0) {
         
            ADExamTextField *textField = [[ADExamTextField alloc]initWithFrame:CGRectMake(0, 0, kExamTextFieldWidth, kExamTextFieldHeight)];
            textField.textColor = [UIColor colorWithRed:255.0/255 green:155.0/255 blue:26.0/255 alpha:1];
            textField.textAlignment = NSTextAlignmentCenter;
            textField.font = [UIFont systemFontOfSize:16];
            
            ADViewStorage *viewStorage = [[ADViewStorage alloc]init];
            viewStorage.range = capturedRanges[0];
            viewStorage.view = textField;
            viewStorage.tag = kTextFieldTag + textFieldArray.count;;

            [textFieldArray addObject:viewStorage];
        }
        
    }];

    return textFieldArray.count > 0 ?[textFieldArray copy] : nil;
}

- (void)addTextAttributedLabel
{
    ADAttributedLabel *label = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(10, 0, kAttrLabelWidth, 0)];
    [_scrollView addSubview:label];
    _label = label;
    label.delegate = self;

    label.textContainer = _textContainer;

    // 或者设置 attString
    //label.attributedText = _attString;

    [label sizeToFit];

    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(label.frame)+10)];
}

- (void)addSubmitAnswerBtn
{
    UIButton *submitAnswerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitAnswerBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 100 -20, CGRectGetMaxY(_label.frame)+15, 100, 32);
    [submitAnswerBtn setTitle:@"提交答案" forState:UIControlStateNormal];
    [submitAnswerBtn setTitle:@"重新作答" forState:UIControlStateSelected];
    submitAnswerBtn.backgroundColor = RGB(80, 180, 20, 1);
    [submitAnswerBtn addTarget:self action:@selector(checkAnswerAction:) forControlEvents:UIControlEventTouchUpInside];

    [_scrollView addSubview:submitAnswerBtn];

    [_scrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(submitAnswerBtn.frame)+20)];
}

#pragma mark - action

- (void)checkAnswerAction:(UIButton *)sender
{
    __typeof (self) __weak weakSelf = self;
    if (!sender.isSelected) {
        [self enumerateTextFieldStorageUseBlock:^(ADViewStorage *viewStorage) {
            if (viewStorage.tag >= kTextFieldTag && viewStorage.tag - kTextFieldTag < _answerArray.count ) {
                [weakSelf judgeTextFieldState:(ADExamTextField *)viewStorage.view answer:_answerArray[viewStorage.tag - kTextFieldTag]];
            }
        }];
    }else {
        [self enumerateTextFieldStorageUseBlock:^(ADViewStorage *viewStorage) {
            [weakSelf resetTextFieldState:(ADExamTextField *)viewStorage.view];
        }];
    }
    sender.selected = !sender.isSelected;
}

// 遍历出 textfiled
- (void)enumerateTextFieldStorageUseBlock:(void(^)(ADViewStorage *viewStorage))block
{
    for (ADTextStorage *textStorage in _textContainer.textStorages) {
        if ([textStorage isKindOfClass:[ADViewStorage class]]) {
            ADViewStorage *viewStorage = (ADViewStorage *)textStorage;
            if ([viewStorage.view isKindOfClass:[ADExamTextField class]]) {
                if (block) {
                    block(viewStorage);
                }
            }
        }
    }
}

// 判断 对错
- (void)judgeTextFieldState:(ADExamTextField *)textField answer:(NSString *)answer
{
    // 判断对错
    if ([textField.text isEqualToString: answer]) {
        textField.examState = ADExamTextFieldStateCorrect;
    }else {
        textField.examState = ADExamTextFieldStateError;
    }
}

// 重置textfield
- (void)resetTextFieldState:(ADExamTextField *)textField
{
    textField.text = nil;
    textField.examState = ADExamTextFieldStateNormal;
}

#pragma mark - delegate

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageClicked:(id<ADTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
    if ([TextRun isKindOfClass:[ADLinkTextStorage class]]) {

        id linkStr = ((ADLinkTextStorage*)TextRun).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }else if ([TextRun isKindOfClass:[ADImageStorage class]]) {
        ADImageStorage *imageStorage = (ADImageStorage *)TextRun;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:[NSString stringWithFormat:@"你点击了%@图片",imageStorage.imageName? imageStorage.imageName: imageStorage.imageURL] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }
}

@end

