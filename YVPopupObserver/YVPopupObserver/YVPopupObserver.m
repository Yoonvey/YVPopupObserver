//
//  YVPopupObserver.m
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/7/24.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import "YVPopupObserver.h"

#import "UIView+YVFrame.h"

#define YVScreenWidth      [UIScreen mainScreen].bounds.size.width
#define YVScreenHeight     [UIScreen mainScreen].bounds.size.height

#pragma mark - <YVPopupObserver>
@implementation YVPopupObserver

static YVPopupObserver *observer = nil;

#pragma mark - <Singleton>
+ (instancetype)sharedObserver
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        observer = [[YVPopupObserver alloc]init];
    });
    return observer;
}

+ (id)alloc
{
    if (observer == nil)
    {
        return [super alloc];
    }
    else
    {
        return nil;
    }
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

#pragma mark PopupAnimation
- (void)showAlertWithAnimationParam:(YVAnimationParam *)animationParam customView:(UIView *)customView
{
    UIView *superView = (UIView *)[UIApplication sharedApplication].delegate.window;
    YVAnimationParam *animeParam = animationParam ? animationParam : [[YVAnimationParam alloc] init] ;
    
    UIView *maskView = nil;
    if (animeParam.isMask)
    {
        maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YVScreenWidth, YVScreenHeight)];
        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        YVTapGestureRecognizer *tapGS = [[YVTapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissAlert:)];
        tapGS.delegate = self;
        tapGS.subObject = animeParam;
        [maskView addGestureRecognizer:tapGS];
        [maskView addSubview:customView];
        [superView addSubview:maskView];
    }
    else
    {
        [superView addSubview:customView];
    }
    
    customView.alpha = 0;
    customView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    customView.center = superView.center;
    
    [UIView animateWithDuration:animeParam.showDuration
                          delay:animeParam.delay
         usingSpringWithDamping:animeParam.springDamping
          initialSpringVelocity:animeParam.springVelocity
                        options:animeParam.options
                     animations:^
     {
         customView.alpha = 1;
         customView.layer.transform = CATransform3DMakeScale(1, 1, 1);
         customView.center = superView.center;
         if (maskView)
         {
             maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:animeParam.maskAlpha];
         }
     }
                     completion:nil];
}

- (void)dismissAlert:(YVTapGestureRecognizer *)tapGS
{
    YVAnimationParam *animeParam = (YVAnimationParam *)tapGS.subObject;
    UIView *maskView = tapGS.view;
    UIView *customView = (UIView *)[[maskView subviews] lastObject];
    
    CGPoint touchPoint = [tapGS locationOfTouch:0 inView:maskView];
    BOOL touch = [customView.layer containsPoint:touchPoint];
    NSLog(@"touchPoint.x>%f, touch>%i", touchPoint.x, touch);
    
    [UIView animateWithDuration:animeParam.dismissDuration
                     animations:^
     {
         customView.alpha = 0;
         customView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
         customView.center = maskView.center;
         maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             [maskView removeFromSuperview];
         }
     }];
}

- (void)dismissAlertWithAnimationParam:(YVAnimationParam *)animationParam customView:(UIView *)customView
{
    YVAnimationParam *animeParam = animationParam ? animationParam : [[YVAnimationParam alloc] init] ;
    UIView *superView = (UIView *)[customView superview];
    
    [UIView animateWithDuration:animeParam.dismissDuration
                     animations:^
     {
         customView.alpha = 0;
         customView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
         customView.center = superView.center;
         if (animeParam.isMask)
         {
             superView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
         }
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             [customView removeFromSuperview];
             if (animeParam.isMask)
             {
                 [superView removeFromSuperview];
             }
         }
     }];
}

#pragma mark PushAnimation
- (void)showPushWithAnimationParam:(YVAnimationParam *)animationParam customView:(UIView *)customView direction:(PushDirection)direction deviant:(CGFloat)deviant
{
    UIView *superView = (UIView *)[UIApplication sharedApplication].delegate.window;
    YVAnimationParam *animeParam = animationParam ? animationParam : [[YVAnimationParam alloc] init] ;
    CGFloat startCenterY = direction == PushDirectionUp ? YVScreenHeight +  (customView.y_height)*0.5: -customView.y_height*0.5 ;
    CGFloat endCenterY = direction == PushDirectionUp ? YVScreenHeight - (customView.y_height*0.5 + deviant) : (customView.y_height*0.5 + deviant) ;
    
    UIView *maskView = nil;
    if (animeParam.isMask)
    {
        maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YVScreenWidth, YVScreenHeight)];
        maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        
        YVTapGestureRecognizer *tapGS = [[YVTapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissPush:)];
        tapGS.delegate = self;
        tapGS.subObject = animeParam;
        tapGS.direction = direction;
        [maskView addGestureRecognizer:tapGS];
        [maskView addSubview:customView];
        [superView addSubview:maskView];
    }
    else
    {
        [superView addSubview:customView];
    }
    
    customView.center = CGPointMake(superView.y_centerX, startCenterY);
    
    [UIView animateWithDuration:animeParam.showDuration
                          delay:animeParam.delay
         usingSpringWithDamping:animeParam.springDamping
          initialSpringVelocity:animeParam.springVelocity
                        options:animeParam.options
                     animations:^
     {
         customView.alpha = 1;
         customView.center = CGPointMake(superView.y_centerX, endCenterY);
         if (maskView)
         {
             maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:animeParam.maskAlpha];
         }
     }
                     completion:nil];
}

- (void)dismissPush:(YVTapGestureRecognizer *)tapGS
{
    YVAnimationParam *animeParam = (YVAnimationParam *)tapGS.subObject;
    PushDirection direction = tapGS.direction;
    
    UIView *maskView = tapGS.view;
    UIView *customView = (UIView *)[[maskView subviews] lastObject];
    
    CGFloat endCenterY = (direction == PushDirectionUp) ? YVScreenHeight + customView.y_height*0.5 : -customView.y_height*0.5 ;
    
    [UIView animateWithDuration:animeParam.dismissDuration
                     animations:^
     {
         customView.alpha = 0;
         customView.center = CGPointMake(maskView.y_centerX, endCenterY);
         maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             [maskView removeFromSuperview];
         }
     }];
}

- (void)dismissPushWithAnimationParam:(YVAnimationParam *)animationParam direction:(PushDirection)direction customView:(UIView *)customView
{
    YVAnimationParam *animeParam = animationParam ? animationParam : [[YVAnimationParam alloc] init] ;
    UIView *superView = (UIView *)[customView superview];
    
    CGFloat endCenterY = (direction == PushDirectionUp) ? YVScreenHeight + customView.y_height*0.5 : -customView.y_height*0.5 ;
    
    [UIView animateWithDuration:animeParam.dismissDuration
                     animations:^
     {
         customView.alpha = 0;
         customView.center = CGPointMake(superView.y_centerX, endCenterY);
         if (animeParam.isMask)
         {
             superView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
         }
     }
                     completion:^(BOOL finished)
     {
         if (finished)
         {
             [customView removeFromSuperview];
             if (animeParam.isMask)
             {
                 [superView removeFromSuperview];
             }
         }
     }];
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *maskView = gestureRecognizer.view;
    UIView *customView = (UIView *)[[maskView subviews] lastObject];
    if ([touch.view isDescendantOfView:customView])
    {
        return NO;
    }
    return YES;
}

@end

#pragma mark - <YVAnimationParam>
@implementation YVAnimationParam

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupCommon];
    }
    return self;
}

- (void)setupCommon
{
    self.isMask = YES;
    self.isSpring = YES;
    self.maskAlpha = 0.6;
    self.showDuration = 0.3;
    self.dismissDuration = 0.3;
    self.delay = 0.0;
    self.springDamping = 0.3;
    self.springVelocity = 10;
    self.options = UIViewAnimationOptionCurveEaseInOut;
}

- (void)setMaskAlpha:(CGFloat)maskAlpha
{
    _maskAlpha = maskAlpha;
    if (maskAlpha <= 0)
    {
        self.isMask = NO;
    }
    else
    {
        self.isMask = YES;
    }
}

- (void)setIsSpring:(BOOL)isSpring
{
    _isSpring = isSpring;
    if(!isSpring)//关闭回弹效果
    {
        self.springDamping = 1.0f;
    }
    else
    {
        self.springDamping = 0.3;
    }
}

@end

#pragma mark - <YVTapGestureRecognizer>
@implementation YVTapGestureRecognizer

@end
