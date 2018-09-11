//
//  YVPopupMaskView.m
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/8/4.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import "YVPopupMaskView.h"

@implementation YVPopupMaskView

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    [self setNeedsDisplay];
}

//绘制尖角
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    //设置背景颜色
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context, rect.size.width*0.5, 0);//设置起点
    CGContextAddLineToPoint(context, 0, rect.size.height);//左边终点
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);//右边终点
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    [self.fillColor setFill]; //设置填充色
    [self.strokeColor setStroke]; //设置边框颜色
    CGContextDrawPath(context, kCGPathFillStroke);//绘制路径path
}

@end
