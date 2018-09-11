//
//  SampleViewController.m
//  YVPopupObserver
//
//  Created by Yoonvey on 2018/7/25.
//  Copyright © 2018年 Yoonvey. All rights reserved.
//

#import "SampleViewController.h"

#import "YVPopupObserver.h"
#import "UIView+YVFrame.h"

#define ScreenWidth      [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height

static NSString *cellId = @"UITableViewCell";

@interface SampleViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *listView;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation SampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupStyleInitialized];
    [self setupListView];
}

- (void)setupStyleInitialized
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"示例";
    self.titles = [NSArray arrayWithObjects:@"Pop", @"Push-Down", @"Push-Up", nil];
}

- (void)setupListView
{
    self.listView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    [self.listView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
}

- (void)showAlert
{
    UIView *view = [[UIView alloc] init];
    view.y_size = CGSizeMake(ScreenWidth - 60, 200);
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.layer.cornerRadius = 5;
    
    UIButton *verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    verBtn.frame = CGRectMake(10, 30, 70, 30);
    verBtn.titleLabel.font = [UIFont systemFontOfSize:13*YVWidthScale];
    [verBtn setTitle:@"垂直移动" forState:UIControlStateNormal];
    [verBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [verBtn addTarget:self action:@selector(verMoving:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:verBtn];
    
    UIButton *horBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    horBtn.frame = CGRectMake(view.y_width - 80, 30, 70, 30);
    horBtn.titleLabel.font = [UIFont systemFontOfSize:13*YVWidthScale];
    [horBtn setTitle:@"水平移动" forState:UIControlStateNormal];
    [horBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [horBtn addTarget:self action:@selector(horMoving:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:horBtn];
    
    [[YVPopupObserver sharedObserver] showAlertWithAnimationParam:nil customView:view];
}
- (void)verMoving:(UIButton *)button
{
    if (!button.selected)
    {
        [[YVPopupObserver sharedObserver] moveCustomViewWithDuration:0.3 deviantDirection:DeviantDirectionVertical deviant:-56];
    }
    else
    {
        [[YVPopupObserver sharedObserver] recoverCustomViewInitialCenter];
    }
    button.selected = !button.selected;
}

- (void)horMoving:(UIButton *)button
{
    if (!button.selected)
    {
        [[YVPopupObserver sharedObserver] moveCustomViewWithDuration:0.3 deviantDirection:DeviantDirectionHorizontal deviant:-56];
    }
    else
    {
        [[YVPopupObserver sharedObserver] recoverCustomViewInitialCenter];
    }
    button.selected = !button.selected;
}

- (void)showPushOfDown
{
    UIView *view = [[UIView alloc] init];
    view.y_size = CGSizeMake(ScreenWidth, 200);
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.layer.cornerRadius = 5;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(10, 30, 50, 30);
    [closeBtn setTitle:@"关闭窗口" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closePushOfDown:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:closeBtn];
    
    //动画设置(也可以传nil)
    YVAnimationParam *param = [[YVAnimationParam alloc] init];
    param.isSpring = NO;
    param.maskAlpha = 0.4;
    
    [[YVPopupObserver sharedObserver] showPushWithAnimationParam:param customView:view direction:PushDirectionDown deviant:0];
}
- (void)closePushOfDown:(UIButton *)button
{
    [[YVPopupObserver sharedObserver] dismissPushWithAnimationParam:nil direction:PushDirectionDown customView:[button superview]];
}

- (void)showPushOfUp
{
    UIView *view = [[UIView alloc] init];
    view.y_size = CGSizeMake(ScreenWidth, 200);
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.layer.cornerRadius = 5;
    
    [[YVPopupObserver sharedObserver] showPushWithAnimationParam:nil customView:view direction:PushDirectionUp deviant:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = self.titles[indexPath.row];
    cell.textLabel.contentMode = UIViewContentModeLeft;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 1:
            [self showPushOfDown];
            break;
        case 2:
            [self showPushOfUp];
            break;
        default:
            [self showAlert];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
