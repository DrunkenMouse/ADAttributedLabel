//
//  ParseTextViewController.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/17.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//

#import "ParseTextViewController.h"
#import "ADAttributedLabel.h"
#import "ADTextStorageParser.h"


@interface ParseTextViewController ()<ADAttributedLabelDelegate>
@property (nonatomic, weak) ADAttributedLabel *label;

@end

@implementation ParseTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // appendAttributedText
    [self addTextAttributedLabel];

    // jsonPathad
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    
    self.view.backgroundColor = [UIColor whiteColor];

    // parseJson
    [self parseJsonFileWithPath:path];

    [_label sizeToFit];
}

- (void)addTextAttributedLabel
{
    ADAttributedLabel *label = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 0)];
    label.delegate = self;
    [self.view addSubview:label];
    _label = label;
}

- (void)parseJsonFileWithPath:(NSString *)filePath
{
    NSArray *textStorageArray = [ADTextStorageParser parseWithJsonFilePath:filePath];

    if (textStorageArray.count > 0) {
        [_label appendTextStorageArray:textStorageArray];
    }
}

#pragma mark - ADAttributedLabelDelegate

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageClicked:(id<ADTextStorageProtocol>)TextStorage atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
    if ([TextStorage isKindOfClass:[ADLinkTextStorage class]]) {
        NSString *linkStr = ((ADLinkTextStorage*)TextStorage).linkData;

        if ([linkStr hasPrefix:@"http"]) {
            [ [ UIApplication sharedApplication] openURL:[ NSURL URLWithString:linkStr]];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageLongPressed:(id<ADTextStorageProtocol>)textStorage onState:(UIGestureRecognizerState)state atPoint:(CGPoint)point
{
    NSLog(@"textStorageLongPressed");
}
@end
