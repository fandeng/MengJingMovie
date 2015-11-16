//
//  AppDelegate.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/22.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "UMSocial.h"
#import "AFNetworkReachabilityManager.h"
#import "HomepageViewController.h"
#import "LMovieViewController.h"
#import "ZShopViewController.h"
#import "FindFirstViewController.h"
#import "GuidanceViewController.h"

@interface AppDelegate ()<CLLocationManagerDelegate,UIAlertViewDelegate>

@property(nonatomic, strong)CLLocationManager * locationManager;//定位


@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#pragma mark----第三方分享
    [UMSocialData setAppKey:@"5613b714e0f55a347a008968"];
    
    
#pragma mark ----判断网络
    [self opinionNetwork];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];

    //判断是不是第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        CLog(@"第一次启动");
        //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        GuidanceViewController *guideViewController = [[GuidanceViewController alloc] init];
        self.window.rootViewController = guideViewController;
        
    }else {
        
        CLog(@"不是第一次启动");
        //如果不是第一次启动的话,使用LoginViewController作为根视图
        [self RootViewController];
    }
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)RootViewController{
    
    
#pragma mark  -----创建视图控制器
    //首页界面
    HomepageViewController * homepageVC = [[UIStoryboard storyboardWithName:@"Homepage" bundle:nil] instantiateViewControllerWithIdentifier:@"homepage"];
    
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:homepageVC];
    [NC.navigationBar setBackgroundImage:[UIImage imageNamed:@"hudie"] forBarMetrics:UIBarMetricsDefault];
    UIImage * image1 = [UIImage imageNamed:@"home"];
    //对图片进行渲染模式设置 注意:需要一个新的指针(对象)来接收
    UIImage * image2 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homepageVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image2 tag:100];
    //电影界面
    LMovieViewController * lShowVC = [[UIStoryboard storyboardWithName:@"Show" bundle:nil] instantiateViewControllerWithIdentifier:@"lshow"];
    
    UINavigationController * lNC = [[UINavigationController alloc] initWithRootViewController:lShowVC];
    [lNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"hudie"] forBarMetrics:UIBarMetricsDefault];
    UIImage * image = [UIImage imageNamed:@"movie1"];
    //对图片进行渲染模式设置 注意:需要一个新的指针(对象)来接收
    UIImage * image3 = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    lShowVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"电影" image:image3 tag:101];
    //商城界面
    ZShopViewController * zShopVC = [[UIStoryboard storyboardWithName:@"Shop" bundle:nil] instantiateViewControllerWithIdentifier:@"zshop"];
    
    //    UINavigationController * zNC = [[UINavigationController alloc] initWithRootViewController:zShopVC];
    UIImage * image4 = [UIImage imageNamed:@"shop"];
    //对图片进行渲染模式设置 注意:需要一个新的指针(对象)来接收
    UIImage * image5 = [image4 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    zShopVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"商城" image:image5 tag:102];
    //发现界面
    FindFirstViewController * wFindVC = [[UIStoryboard storyboardWithName:@"Find" bundle:nil] instantiateViewControllerWithIdentifier:@"wfind"];
    
    UINavigationController * wNC = [[UINavigationController alloc] initWithRootViewController:wFindVC];
    [wNC.navigationBar setBackgroundImage:[UIImage imageNamed:@"hudie"] forBarMetrics:UIBarMetricsDefault];
    UIImage * image6 = [UIImage imageNamed:@"find"];
    //对图片进行渲染模式设置 注意:需要一个新的指针(对象)来接收
    UIImage * image7 = [image6 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wFindVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:image7 tag:103];
    
    //创建标签视图
    _TBC = [[UITabBarController alloc] init];
    
    _TBC.viewControllers = @[NC,lNC,zShopVC,wNC];
    //①.设置TabBar颜色
    _TBC.tabBar.barTintColor = [UIColor whiteColor];
    //②.设置TabBar上控件的颜色

    _TBC.tabBar.tintColor = [UIColor blackColor];
    
    _window.rootViewController = _TBC;
    

    
}
//判断网络
- (void)opinionNetwork
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case -1:{
                
                break;
            }
            case 0: {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络连接状态" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alertView show];
                [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:1.0];
                break;
            }
            case 1:{
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前的网络状态:2G/3G/4G,请君慎重" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alertView show];
                [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:1.0];
                break;
            }
            case 2: {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前的网络状态:WIFI,可以放心使用" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
                [alertView show];
                [self performSelector:@selector(removeAlertView:) withObject:alertView afterDelay:1.0];
                break;
            }
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
//alertView消失
- (void)removeAlertView:(UIAlertView *)alertView
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self stopLocation];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
#pragma mark -----定位，初始化管理者
    self.locationManager = [[CLLocationManager alloc]init];
    //开启定位
    [self.locationManager startUpdatingLocation];
    //授权
    [_locationManager requestWhenInUseAuthorization];
    //绑定代理
    self.locationManager.delegate = self;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSString * currentArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"opinionCount"];
    
    if ([currentArray integerValue] == 1) {
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否允许定位" delegate:self cancelButtonTitle:@"不允许" otherButtonTitles:@"允许", nil];
        
        [alertView show];
    } else {
        return;
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        return;
    } else if (buttonIndex == 1){
#pragma mark -----定位，初始化管理者
        self.locationManager = [[CLLocationManager alloc]init];
        //开启定位
        [self.locationManager startUpdatingLocation];
        //授权
        [_locationManager requestWhenInUseAuthorization];
        //绑定代理
        self.locationManager.delegate = self;
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"opinionCount"];
    }
}
//结束定位
-(void)stopLocation{
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}
#pragma mark -------实现CLLocationManagerDelegate协议方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * currLocation = locations.firstObject;
    
    CLGeocoder * geo = [[CLGeocoder alloc] init];
    
    [geo reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark * mark = placemarks.firstObject;
        
        [ShareRequestData sharedManager].city = [mark.locality substringToIndex:mark.locality.length-1];
    }];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
