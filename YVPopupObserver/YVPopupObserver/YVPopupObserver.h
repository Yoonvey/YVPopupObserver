//
//  YVPopupObserver.h
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/7/24.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YVPopupCommon.h"

@class YVAnimationParam;
@class YVTapGestureRecognizer;

@interface YVPopupObserver : NSObject <UIGestureRecognizerDelegate>

+ (instancetype)sharedObserver;

#pragma mark - <PopupAnimation>
/*!
 * @brief Popup方式弹出视图
 * @param animationParam 动画设置对象(传nil时将启用默认设置)
 * @param customView 要展示的视图
 */
- (void)showAlertWithAnimationParam:(YVAnimationParam *)animationParam
                         customView:(UIView *)customView;

/*!
 * @brief PopupView设置偏移
 * @param duration 动画时长
 * @param direction 偏移方向
 * @param deviant 偏移量(负数向左/上， 正数向右/下)
 */
- (void)moveCustomViewWithDuration:(CGFloat)duration
                  deviantDirection:(DeviantDirection)direction
                           deviant:(CGFloat)deviant;
//回复初始坐标
- (void)recoverCustomViewInitialCenter;

/*!
 * @brief Dismiss弹出视图 (在不需要蒙版的情况下, 调用此方法隐藏弹出视图)
 * @param animationParam 动画设置对象(传nil时将启用默认设置)
 * @param customView 要展示的视图
 */
- (void)dismissAlertWithAnimationParam:(YVAnimationParam *)animationParam
                            customView:(UIView *)customView;

#pragma mark - <PushAnimation>
/*!
 * @brief Push方式弹出视图
 * @param animationParam 动画设置对象(传nil时将启用默认设置)
 * @param customView 要展示的视图
 * @param direction Push方向
 * @param deviant 偏移值(视图展示时默认与边界贴合, 偏移值的设置会使视图便宜, 与direction成反比)
 */
- (void)showPushWithAnimationParam:(YVAnimationParam *)animationParam
                        customView:(UIView *)customView
                         direction:(PushDirection)direction
                           deviant:(CGFloat)deviant;

/*!
 * @brief Dismiss弹出视图 (在不需要蒙版的情况下, 调用此方法隐藏弹出视图)
 * @param animationParam 动画设置对象(传nil时将启用默认设置)
 * @param direction Push方向
 * @param customView 要展示的视图
 */
- (void)dismissPushWithAnimationParam:(YVAnimationParam *)animationParam
                            direction:(PushDirection)direction
                           customView:(UIView *)customView;

@end

@interface YVAnimationParam : NSObject

@property (nonatomic) BOOL isMask;//蒙版, 默认为YES
@property (nonatomic) BOOL isSpring;//弹簧效果, 默认为YES

@property (nonatomic) CGFloat maskAlpha;//蒙版透明度, 默认为0.3
@property (nonatomic) CGFloat showDuration;//视图出现动画需要时长, 默认为0.3s
@property (nonatomic) CGFloat dismissDuration;//视图隐藏动画需要时长, 默认为0.3s
@property (nonatomic) CGFloat delay;//动画执行延迟的时间, 默认为0s
@property (nonatomic) CGFloat springDamping;//回弹的频率, 默认为0.4
@property (nonatomic) CGFloat springVelocity;//回弹速度, 默认为10
@property (nonatomic) UIViewAnimationOptions options;//动画效果, 默认为UIViewAnimationOptionCurveEaseInOut

@end

@interface YVTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, strong) id subObject;//点击手势附带动画效果设置
@property (nonatomic) PushDirection direction;//推出的方向a

@end
