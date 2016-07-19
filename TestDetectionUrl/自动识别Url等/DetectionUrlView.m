//
//  DetectionUrlView.m
//  TestDetectionUrl
//
//  Created by 王然 on 16/7/18.
//  Copyright © 2016年 wangran. All rights reserved.
//

#import "DetectionUrlView.h"

@interface DetectionUrlView()<TTTAttributedLabelDelegate>

@property (nonatomic , strong) TTTAttributedLabel * aLabel;

@property (nonatomic , strong) UIColor * canClickColor;

@end
@implementation DetectionUrlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createAttributeLabel];
    }
    return self;
}
- (void)createAttributeLabel
{
    self.aLabel = [[TTTAttributedLabel alloc]initWithFrame:self.bounds];
    self.aLabel.font= [UIFont systemFontOfSize:14];
    self.aLabel.textColor = [UIColor blackColor];
    self.aLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.aLabel.backgroundColor = [UIColor yellowColor];
    self.aLabel.numberOfLines = 0;
    //设置高亮颜色
    self.aLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
    self.aLabel.lineSpacing = 7;
    self.aLabel.highlightedTextColor = [UIColor greenColor];
    self.aLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber;
    self.aLabel.delegate = self;
    [self addSubview:self.aLabel];
}

- (void)resetDetectionTextColor:(UIColor *)normalTextColor highlightTextColor:(UIColor *)highlightTextColor textFont:(UIFont *)font canClickColor:(UIColor *)canClickColor isClickHaveLine:(BOOL)isClickHaveLine
{
    self.aLabel.textColor = normalTextColor;
    self.aLabel.highlightedTextColor = highlightTextColor;
    self.aLabel.font = font;
    self.canClickColor = canClickColor;
    
    self.aLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:isClickHaveLine] forKey:(NSString *)kCTUnderlineStyleAttributeName];
}
- (void)detectionWithStr:(NSString *)detectionStr clickTextFont:(UIFont *)cFont textCheckType:(NSTextCheckingTypes) enabledTextCheckingTypes
{
    if (enabledTextCheckingTypes) {
        self.aLabel.enabledTextCheckingTypes = enabledTextCheckingTypes;
    }
    
    NSError * error = nil;
    //根据监测的类型初始化NSDataDetector
    NSDataDetector * detector = [NSDataDetector dataDetectorWithTypes:self.aLabel.enabledTextCheckingTypes error:&error];
    //需要监测的字符串,可以有多种方法检测匹配的数据
    //1.检测然后对每个检测到的数据进行操作
    __weak __typeof(self) wself = self;
    NSMutableArray * rangeArr = [NSMutableArray arrayWithCapacity:0];
    [detector enumerateMatchesInString:detectionStr options:kNilOptions range:NSMakeRange(0, detectionStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSLog(@"_____resule.range:%@____",NSStringFromRange(result.range));
        
        [rangeArr addObject: [NSValue valueWithRange:result.range]];
        if (result.URL) {
            NSLog(@"_____resule.url:%@____",result.URL);
            [wself.aLabel addLinkToURL:result.URL withRange:result.range];
        }
        if (result.phoneNumber) {
            NSLog(@"_____resule.phoneNum:%@____",result.phoneNumber);
            [wself.aLabel addLinkToPhoneNumber:result.phoneNumber withRange:result.range];
        }
        if (result.addressComponents) {
            NSLog(@"addressComponents:%@____",result.addressComponents);
            [wself.aLabel addLinkToAddress:result.addressComponents withRange:result.range];
        }
        
    }];
    
    [self.aLabel setText:detectionStr afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        for (NSValue * value in rangeArr) {
            NSRange range = value.rangeValue;
            UIFont * boldSystemFont = (cFont ? cFont : [UIFont boldSystemFontOfSize:16]);
            CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
            if (font) {
                //设置可点击文本的大小
                [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:range];
            }
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)[(wself.canClickColor ? wself.canClickColor : [UIColor blueColor])CGColor] range:range];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];


}
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    if (self.delegate) {
        [self.delegate attributedLabel:label didSelectLinkWithPhoneNumber:phoneNumber];
    }
    
}
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if (self.delegate) {
        [self.delegate attributedLabel:label didSelectLinkWithURL:url];
    }
    
}
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents
{
    
}
- (void)setLineSpacing:(CGFloat)lineSpacing
{
    _lineSpacing = lineSpacing;
    self.aLabel.lineSpacing = lineSpacing;
}
- (void)setVerticalAlignment:(TTTAttributedLabelVerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    self.aLabel.verticalAlignment = verticalAlignment;
}
@end
