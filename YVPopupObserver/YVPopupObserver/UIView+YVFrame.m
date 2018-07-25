//
//  UIView+YVFrame.m
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/7/24.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import "UIView+YVFrame.h"

@implementation UIView (YVFrame)

#pragma mark - Shortcuts for the coords

- (CGFloat)y_top
{
    return self.frame.origin.y;
}

- (void)setY_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setY_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)y_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setY_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)y_left
{
    return self.frame.origin.x;
}

- (void)setY_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y_width
{
    return self.frame.size.width;
}

- (void)setY_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)y_height
{
    return self.frame.size.height;
}

- (void)setY_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)y_origin {
    return self.frame.origin;
}

- (void)setY_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)y_size {
    return self.frame.size;
}

- (void)setY_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)y_centerX {
    return self.center.x;
}

- (void)setY_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)y_centerY {
    return self.center.y;
}

- (void)setY_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


@end
