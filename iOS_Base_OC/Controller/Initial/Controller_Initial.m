//
//  Controller_Initial.m
//  iOS_Base_OC
//
//  Created by Jakin on 2018/1/17.
//  Copyright © 2018年 Jakin. All rights reserved.
//

#import "Controller_Initial.h"

#import "RDVTabBarItem.h"
#import "Controller_Home.h"
#import "Controller_Product.h"
#import "Controller_Activity.h"
#import "Controller_Me.h"

@interface Controller_Initial () <RDVTabBarControllerDelegate>

@end

@implementation Controller_Initial

- (id)init {
    if (self = [super init]) {
        [self setupViewControllers];
        self.tabBar.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    if (isIPhoneX) {
        [self.tabBar setHeight:kTabBarHeight];
        CGFloat top = self.tabBar.contentEdgeInsets.top;
        CGFloat left = self.tabBar.contentEdgeInsets.left;
        CGFloat right = self.tabBar.contentEdgeInsets.right;
        CGFloat bottom = kTabBarContentEdgeInsetsBottom;
        [self.tabBar setContentEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
    }
}

#pragma mark - Methods
- (void)setupViewControllers {
    
    NSMutableArray *controllers = [NSMutableArray array];
    
    [controllers addObject:[self setupWithRootViewController:[[Controller_Home alloc] init]]];
    [controllers addObject:[self setupWithRootViewController:[[Controller_Product alloc] init]]];
    [controllers addObject:[self setupWithRootViewController:[[Controller_Activity alloc] init]]];
    [controllers addObject:[self setupWithRootViewController:[[Controller_Me alloc] init]]];
    
    [self setViewControllers:controllers];
    
    [self customizeTabBarForController];
}

- (UINavigationController *)setupWithRootViewController:(UIViewController *)controller {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    return navigationController;
}

- (void)customizeTabBarForController {
    NSArray *selectImageNames = @[@"loan_select", @"asset_select", @"activity_select", @"me_select"];
    NSArray *unSelectImageNames = @[@"loan_normal", @"asset_normal", @"activity_normal", @"me_normal"];
    NSArray *tabBarItemTitles = @[@"去玩", @"消息", @"活动", @"我"];
    NSString *titleColorNormal = @"787878";
    NSString *titleColorSelected = AppThemeColor;
    
    UIView *sperateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIMainScreen), [Tools CGFloatFromPixel:isIPhoneX ? 2 : 1])];
    sperateView.backgroundColor = [Tools colorWithHexString:@"dddddd"];
    [self.tabBar.backgroundView addSubview:sperateView];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        UIImage *selectedimage = [UIImage imageNamed:selectImageNames[index]];
        UIImage *unselectedimage = [UIImage imageNamed:unSelectImageNames[index]];
        [item setFinishedSelectedImage:selectedimage  withFinishedUnselectedImage:unselectedimage];
        item.title = tabBarItemTitles[index];
        
        [item setUnselectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                            [Tools colorWithHexString:titleColorNormal], NSForegroundColorAttributeName, nil]];
        [item setSelectedTitleAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                          [Tools colorWithHexString:titleColorSelected], NSForegroundColorAttributeName, nil]];
        
        index++;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSInteger index = tabBarController.selectedIndex;
    RDVTabBarItem *tabItem = self.tabBar.items[index];
    [self addRotateAnimationOnView:tabItem];
}

- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}
@end
