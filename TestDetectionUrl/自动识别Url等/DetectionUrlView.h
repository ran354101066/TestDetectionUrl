//
//  DetectionUrlView.h
//  TestDetectionUrl
//
//  Created by 王然 on 16/7/18.
//  Copyright © 2016年 wangran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@protocol DetectionUrlViewDelegate <NSObject>

@optional
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber;
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url;

@required


@end

@interface DetectionUrlView : UIView

//垂直对齐方式
@property (nonatomic, assign) TTTAttributedLabelVerticalAlignment verticalAlignment;

//对齐方式
@property (nonatomic, assign) IBInspectable CGFloat lineSpacing;


@property (nonatomic , weak) id<DetectionUrlViewDelegate> delegate;
/**
 设置文本的常规颜色 normalTextColor 文本高亮颜色highlightTextColor 文本的font 文本链接、电话等颜色canClickColor 可点击的部分是否有下划线isClickHaveLine YES是有下划线 否则是NO
 */
- (void)resetDetectionTextColor:(UIColor *)normalTextColor highlightTextColor:(UIColor *)highlightTextColor textFont:(UIFont *)font canClickColor:(UIColor *)canClickColor isClickHaveLine:(BOOL)isClickHaveLine;

/**
 设置需要检测的文本内容detextionStr cFont可点击的文字font 检测内容的类型url、phoneNum、address等默认url、phoneNum
 */
- (void)detectionWithStr:(NSString *)detectionStr clickTextFont:(UIFont *)cFont textCheckType:(NSTextCheckingTypes) enabledTextCheckingTypes;
@end
