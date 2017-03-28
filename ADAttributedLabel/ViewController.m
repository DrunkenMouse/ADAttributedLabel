//
//  ViewController.m
//  ADAttributedLabel
//
//  Created by 王奥东 on 17/1/10.
//  Copyright © 2017年 DrunkenMouse. All rights reserved.
//
// 参考TYAttributedLabel：https://github.com/12207480/TYAttributedLabel

#import "ViewController.h"
#import "ADAttributeLabel/ADAttributedLabel.h"


#import "AutoLayoutViewController.h"
#import "ImageTextViewController.h"
#import "AddViewTextViewController.h"
#import "TextContainerViewController.h"
#import "TextTableViewController.h"
#import "ParseTextViewController.h"

#define RGB(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


static NSString *const cellID = @"ADCellID";
@interface ViewController ()<ADAttributedLabelDelegate,UITableViewDelegate,UITableViewDataSource>//VC2 VC3
@property (nonatomic, weak) ADAttributedLabel *label1;//VC2 VC3
@end

@implementation ViewController {
    NSArray *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    
    _array = @[@"ParseTextViewController",@"TextTableViewController",@"TextContainerViewController",@"AddViewTextViewController",@"ImageTextViewController",@"AutoLayoutViewController"];
    
    [self.view addSubview:tableView];
}

#pragma mark - - - - - - delegate & dataSource - - - - - - 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _array[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = _array[indexPath.row];
    
    Class cl = NSClassFromString(str);
    id obj = [[cl alloc] init];

    [self.navigationController pushViewController:obj animated:NO];
}



#pragma mark - 属性链接文本显示
- (void)LinkText {
    // appendAttributedText
    [self addLinkTextAttributedLabel1];
    
    // addAttributedText
    [self  addLinkTextAttributedLabel2];
    
}

- (void)addLinkTextAttributedLabel1
{
    ADAttributedLabel *label1 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 0)];
    label1.delegate = self;
    label1.highlightedLinkColor = [UIColor orangeColor];
    [self.view addSubview:label1];
    NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过程会很痛，会很辛苦，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。\n\t我们都将孤独地长大，不要害怕。";

    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
    NSInteger index = 0;

    for (NSString *text in textArray) {

        if (index == 2) {
            // 追加链接信息
            [label1 appendLinkWithText:text linkFont:[UIFont systemFontOfSize:15+arc4random()%4] linkData:@"http://www.baidu.com"];
        }else {
            // 追加文本属性
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
            [attributedString addAttributeTextColor:colorArray[index%5]];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:15+arc4random()%4]];
            [label1 appendTextAttributedString:attributedString];
        }
        [label1 appendText:@"\n\t"];
        index++;
    }

    [label1 appendLinkWithText:@"百度一下" linkFont:[UIFont systemFontOfSize:15+arc4random()%4] linkData:@"http://www.baidu.com"];

    [label1 sizeToFit];
    _label1 = label1;
}

- (void)addLinkTextAttributedLabel2
{
    NSString *text = @"\t任何值得去的地方，都没有捷径；\n\t任何值得等待的人，都会迟来一些；\n\t任何值得追逐的梦想，都必须在一路艰辛中备受嘲笑。\n\t所以，不要怕，不要担心你所追逐的有可能是错的。\n\t因为，不被嘲笑的梦想不是梦想。\n";
    
    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
    NSInteger index = 0;
    NSMutableArray *textRunArray = [NSMutableArray array];

    for (NSString *subText in textArray) {
        if (index == 2) {
            ADLinkTextStorage *linkTextStorage = [[ADLinkTextStorage alloc]init];
            linkTextStorage.range = [text rangeOfString:subText];
            linkTextStorage.font = [UIFont systemFontOfSize:15+arc4random()%4];
            linkTextStorage.textColor = colorArray[index%5];
            linkTextStorage.linkData = @"我被点中了哦O(∩_∩)O~";
            [textRunArray addObject:linkTextStorage];
        } else {
            ADTextStorage *textStorage = [[ADTextStorage alloc]init];
            textStorage.font = [UIFont systemFontOfSize:15+arc4random()%4];
            textStorage.textColor = colorArray[index%5];
            textStorage.range = [text rangeOfString:subText];
            [textRunArray addObject:textStorage];
        }
        index++;
    }

    ADAttributedLabel *label2 = [[ADAttributedLabel alloc]init];
    label2.delegate = self;
    label2.highlightedLinkColor = [UIColor redColor];
    label2.text = text;
    [label2 addTextStorageArray:textRunArray];

    label2.linesSpacing = 8;
    label2.characterSpacing = 2;
    [label2 setFrameWithOrigin:CGPointMake(0, CGRectGetMaxY(_label1.frame)) Width:CGRectGetWidth(self.view.frame)];
    
    [self.view addSubview:label2];
    
}

#pragma mark - ADAttributedLabelDelegate

- (void)attributedLabel:(ADAttributedLabel *)attributedLabel textStorageClicked:(id<ADTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
    if ([TextRun isKindOfClass:[ADLinkTextStorage class]]) {
        
        NSString *linkStr = ((ADLinkTextStorage*)TextRun).linkData;
        
        if ([linkStr hasPrefix:@"http:"]) {
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

#pragma mark - vc2.属性文本
- (void)attributedText {
    // appendAttributedText
    [self addTextAttributedLabel1];
    
    // addAttributedText
    [self addTextAttributedLabel2];
}

// appendAttributedText
- (void)addTextAttributedLabel1
{
    ADAttributedLabel *label1 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 0)];

    [self.view addSubview:label1];
    NSString *text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过程会很痛，会很辛苦，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。\n\t我们都将孤独地长大，不要害怕。";
    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
    NSInteger index = 0;
    for (NSString *text in textArray) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
        //设置当前文本颜色
        [attributedString addAttributeTextColor:colorArray[index%5]];
        //设置当前文本字体
        [attributedString addAttributeFont:[UIFont systemFontOfSize:15+arc4random()%4]];
        if (index == 2) {
            // 当前文本添加下划线
        [attributedString addAttributeUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternSolid];
        }
        if (index == 4) {
        [attributedString addAttributeUnderlineStyle:kCTUnderlineStyleSingle modifier:kCTUnderlinePatternDot];
        }

        // 追加(添加到最后)属性文本
        [label1 appendTextAttributedString:attributedString];
        [label1 appendText:@"\n\t"];
        index++;
    }
    // 设置空心字
    label1.strokeWidth = 1;

    [label1 sizeToFit];
    
    _label1 = label1;
}

// addAttributedText
- (void)addTextAttributedLabel2
{
    NSString *text = @"\t任何值得去的地方，都没有捷径；\n\t任何值得等待的人，都会迟来一些；\n\t任何值得追逐的梦想，都必须在一路艰辛中备受嘲笑。\n\t所以，不要怕，不要担心你所追逐的有可能是错的。\n\t因为，不被嘲笑的梦想不是梦想。\n";
    NSArray *textArray = [text componentsSeparatedByString:@"\n\t"];
    NSArray *colorArray = @[RGB(213, 0, 0, 1),RGB(0, 155, 0, 1),RGB(103, 0, 207, 1),RGB(209, 162, 74, 1),RGB(206, 39, 206, 1)];
    NSInteger index = 0;
    NSMutableAttributedString *totalAttributedString = [[NSMutableAttributedString alloc]init];

    for (NSString *text in textArray) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];

        [attributedString addAttributeTextColor:colorArray[index%5]];
        [attributedString addAttributeFont:[UIFont systemFontOfSize:15+arc4random()%4]];
        [totalAttributedString appendAttributedString:attributedString];
        [totalAttributedString appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n\t"]];
        index++;
    }

    ADAttributedLabel *label2 = [[ADAttributedLabel alloc]init];
    [label2 setAttributedText:totalAttributedString];

    label2.linesSpacing = 5;
    label2.characterSpacing = 2;
    [self.view addSubview:label2];
}


#pragma mark - vc1.简单的文本
-(void)simpleText{
    // addAttributedText
    ADAttributedLabel *label1 = [[ADAttributedLabel alloc] init];
    label1.text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。但这个过程会很痛，会很辛苦，有时候还会觉得灰心。面对着汹涌而来的现实，觉得自己渺小无力。但这，也是生命的一部分。做好现在你能做的，然后，一切都会好的。我们都将孤独地长大，不要害怕。";
    
    // 文字间隙
    label1.characterSpacing = 2;
    // 文本行间隙
    label1.linesSpacing = 2;
    label1.lineBreakMode = kCTLineBreakByTruncatingTail;
    label1.numberOfLines = 1;
    
    //文本字体
    label1.font = [UIFont systemFontOfSize:17];
    
    
    // 设置view的位置和宽，会自动计算高度
    [label1 setFrameWithOrigin:CGPointMake(0, 64) Width:CGRectGetWidth(self.view.frame)];
    [self.view addSubview:label1];
    
    // appendAttributedText
    ADAttributedLabel *label2 = [[ADAttributedLabel alloc] init];
    label2.backgroundColor = [UIColor lightGrayColor];
    label2.frame = CGRectMake(0, CGRectGetMaxY(label1.frame)+10, CGRectGetWidth(self.view.frame), 20);
    [self.view addSubview:label2];
    
    // 追加(添加到最后)文本
    [label2 appendText:@"\t任何值得去的地方"];
    [label2 appendImageWithName:@"haha" size:CGSizeMake(15, 15)];
    [label2 appendText:@",都没“有捷径“"];
    [label2 appendImageWithName:@"haha" size:CGSizeMake(15, 15)];
    [label2 appendText:@"\t任何值得等待的人，都会迟来一些；\n"];
    [label2 appendText:@"\t任何值得追逐的梦想，都必须在一路艰辛中备受嘲笑。\n"];
    [label2 appendText:@"\t所以，不要怕，不要担心你所追逐的有可能是错的。\n"];
    [label2 appendText:@"\t因为，不被嘲笑的梦想不是梦想。\n"];
    // 宽度自适应
    label2.isWidthToFit = YES;
    // 自适应高度
    [label2 sizeToFit];
    
    // label 垂直对齐方式
    // top text(default)
    ADAttributedLabel *label3 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label2.frame)+10, CGRectGetWidth(self.view.frame), 80)];
    label3.text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。(default text)";
    label3.backgroundColor = [UIColor lightGrayColor];
    // 垂直对齐方式
    //label3.verticalAlignment = ADVerticalAlignmentTop; // default top
    // 文字间隙
    label3.characterSpacing = 2;
    // 文本行间隙
    label3.linesSpacing = 2;
    
    [self.view addSubview:label3];
    
    // center text
    ADAttributedLabel *label4 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label3.frame)+10, CGRectGetWidth(self.view.frame), 80)];
    label4.text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。(center text)";
    label4.backgroundColor = [UIColor lightGrayColor];
    // 垂直对齐方式
    label4.verticalAlignment = ADVerticalAlignmentCenter;
    // 文字间隙
    label4.characterSpacing = 2;
    // 文本行间隙
    label4.linesSpacing = 2;
    
    [self.view addSubview:label4];
    
    // bottom text
    ADAttributedLabel *label5 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label4.frame)+10, CGRectGetWidth(self.view.frame), 80)];
    label5.text = @"\t总有一天你将破蛹而出，成长得比人们期待的还要美丽。(bottom text)";
    label5.backgroundColor = [UIColor lightGrayColor];
    // 垂直对齐方式
    label5.verticalAlignment = ADVerticalAlignmentBottom;
    // 文字间隙
    label5.characterSpacing = 2;
    // 文本行间隙
    label5.linesSpacing = 2;
    
    [self.view addSubview:label5];
    
    ADAttributedLabel *label6 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label5.frame)+10, CGRectGetWidth(self.view.frame), 80)];
    label6.text = @"center text";
    label6.backgroundColor = [UIColor lightGrayColor];
    // 水平对齐方式
    label6.textAlignment = kCTTextAlignmentCenter;
    // 垂直对齐方式
    label6.verticalAlignment = ADVerticalAlignmentCenter;
    // 文字间隙
    label6.characterSpacing = 2;
    // 文本行间隙
    label6.linesSpacing = 2;
    
    [self.view addSubview:label6];
    
    ADAttributedLabel *label7 = [[ADAttributedLabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label6.frame)+10, CGRectGetWidth(self.view.frame), 80)];
    label7.text = @"right text";
    label7.backgroundColor = [UIColor lightGrayColor];
    // 水平对齐方式
    label7.textAlignment = kCTTextAlignmentRight;
    // 垂直对齐方式
    label7.verticalAlignment = ADVerticalAlignmentCenter;
    // 文字间隙
    label7.characterSpacing = 2;
    // 文本行间隙
    label7.linesSpacing = 2;
    
    [self.view addSubview:label7];
}


@end
