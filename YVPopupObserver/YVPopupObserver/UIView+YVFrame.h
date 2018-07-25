//
//  UIView+YVFrame.h
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/7/24.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YVFrame)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint y_origin;
@property (nonatomic, assign) CGSize y_size;

// shortcuts for positions
@property (nonatomic) CGFloat y_centerX;
@property (nonatomic) CGFloat y_centerY;


@property (nonatomic) CGFloat y_top;
@property (nonatomic) CGFloat y_bottom;
@property (nonatomic) CGFloat y_right;
@property (nonatomic) CGFloat y_left;

@property (nonatomic) CGFloat y_width;
@property (nonatomic) CGFloat y_height;

@end
