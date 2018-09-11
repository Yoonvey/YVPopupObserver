//
//  YVPopupCommon.h
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/8/3.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#ifndef YVPopupCommon_h
#define YVPopupCommon_h

typedef enum
{
    PushDirectionUp,
    PushDirectionDown
} PushDirection;//推出方向

typedef enum
{
    DeviantDirectionVertical,//垂直偏移
    DeviantDirectionHorizontal//水平偏移
} DeviantDirection;

#import <UIKit/UIKit.h>
#import "UIView+YVFrame.h"

#define YVScreenWidth      [UIScreen mainScreen].bounds.size.width
#define YVScreenHeight     [UIScreen mainScreen].bounds.size.height
#define YVWidthScale ScreenWidth / 375.0f
#define YVHeightScale ScreenHeight / 667.0f

#define YVColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1]
#define YVColorAlpha(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]


#endif /* YVPopupCommon_h */
