//
//  BaseTabBarController.m
//  FileMaster
//
//  Created by Tengfei on 16/3/3.
//  Copyright © 2016年 tengfei. All rights reserved.
//

#import "BaseTabBarController.h"
#import "RDVTabBarItem.h"
#import "BaseNavigationController.h"

#import "UIImage+Tint.h"
#import "UIImage+Category.h"

#import "News_RootController.h"
#import "Cheats_RootController.h"
#import "Heros_RootController.h"
#import "Me_RootController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self setHidesBottomBarWhenPushed:YES];
    //    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    
    [self  initViewControllers];
    
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initViewControllers
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    News_RootController *allVC = [sb instantiateViewControllerWithIdentifier:@"news"];
    BaseNavigationController *allNav = [[BaseNavigationController alloc]initWithRootViewController:allVC];
    
    Cheats_RootController *movieListVc = [sb instantiateViewControllerWithIdentifier:@"cheats"];
    BaseNavigationController *movielistNav = [[BaseNavigationController alloc]initWithRootViewController:movieListVc];

    Heros_RootController *settingVc = [sb instantiateViewControllerWithIdentifier:@"heros"];
    BaseNavigationController *settingNav = [[BaseNavigationController alloc]initWithRootViewController:settingVc];

    Me_RootController *meVC = [sb instantiateViewControllerWithIdentifier:@"me"];

    [self setViewControllers:@[allNav,movielistNav, settingNav]];
    
    [self initTabBarForController];
    self.delegate = self;
}

-(void)initTabBarForController
{
    NSArray *tabBarItemImages = @[@"tab_new2",@"tabbar_cheats",@"tabbar_heros"];
    NSArray *tabBarItemTitles = @[@"游戏资讯",@"攻略秘籍",@"英雄大全"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in self.tabBar.items) {
        item.titlePositionAdjustment = UIOffsetMake(0, 2);
//        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        [[UIImage imageNamed:@"refresh"] imageWithTintColor:[UIColor lightGrayColor]];

        NSString *selectStr = [NSString stringWithFormat:@"%@",
                               tabBarItemImages[index]];
        UIImage *selectedimage = [[UIImage imageNamed:selectStr] imageWithTintColor:KColor(106, 149, 218)];
        
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",
                                                        tabBarItemImages[index]]];
        
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemTitles objectAtIndex:index]];
        item.unselectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : KColor(153, 153, 153)};
        item.selectedTitleAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : KColor(106, 149, 218)};
        
        index++;
    }
}

#pragma mark RDVTabBarControllerDelegate

- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if (tabBarController.selectedViewController != viewController) {
        return YES;
    }
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nav = (UINavigationController *)viewController;
    if (nav.topViewController != nav.viewControllers[0]) {
        return YES;
    }
    return YES;
}


/**
 *  Description
 *
 *  @return return value description
 */
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    UIInterfaceOrientationMask ll = [self.selectedViewController supportedInterfaceOrientations];
//    NSLog(@"-tab-1-:%@--:%lu",self.viewControllers.lastObject,(unsigned long)ll);
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return [self.viewControllers.lastObject supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
//    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
//}


@end
