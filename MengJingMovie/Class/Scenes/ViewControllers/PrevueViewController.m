//
//  PrevueViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/31.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "PrevueViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PrevueViewController ()

//视频播放器
@property (strong, nonatomic) MPMoviePlayerController *player;


@end

@implementation PrevueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel * labelName = [[UILabel alloc] initWithFrame:CGRectMake(80, 90, CGRectGetWidth(self.view.frame) - 60, 30)];
    labelName.text = self.movieName;
    [self.view addSubview:labelName];

    self.player = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:_hightUrl]];
    //1设置播放器的大小
    [self.player.view setFrame:CGRectMake(30, CGRectGetMaxY(labelName.frame) + 20, CGRectGetWidth(self.view.frame) - 60, CGRectGetWidth(self.view.frame)/3*2-10)]; //16:9是主流媒体的样式
    self.player.view.backgroundColor = [UIColor blackColor];
    //2将播放器视图添加到根视图
    
    [self.view addSubview:self.player.view];
    
    //4播放
    [self.player play];
    //[self.player stop];
    //通过通知中心，以观察者模式监听视频播放状态
    //1 监听播放状态
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stateChange) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    //2 监听播放完成
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(finishedPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    //4退出全屏通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //异步视频截图,可以在attimes指定一个或者多个时间。
    [self.player requestThumbnailImagesAtTimes:@[@10.0f, @20.0f] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    [self TabBarController];

}

//返回
- (void)TabBarController {
    
    UIBarButtonItem * LeftBI = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(click:)];
    self.navigationItem.leftBarButtonItem = LeftBI;
}
//返回上一级
- (void)click:(UIBarButtonItem *)BI {
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 退出全屏
- (void)exitFullScreen
{
//    [self.player.view removeFromSuperview];    // 消失播放器
    NSLog(@"退出全屏");
}

#pragma mark 播放器事件监听
#pragma mark 播放完成
- (void)finishedPlay
{
    NSLog(@"播放完成");
}

#pragma mark 播放器视频的监听
#pragma mark 播放状态变化
/*
 MPMoviePlaybackStateStopped,  //停止
 MPMoviePlaybackStatePlaying,  //播放
 MPMoviePlaybackStatePaused,   //暂停
 MPMoviePlaybackStateInterrupted,  //中断
 MPMoviePlaybackStateSeekingForward, //快进
 MPMoviePlaybackStateSeekingBackward  //快退
 */
- (void)stateChange
{
    switch (self.player.playbackState) {
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStatePlaying:
            //设置全屏播放
            [[ShareAnimationLoad ShareAnimation]animationSuccessLoad];
            [self.player setFullscreen:NO animated:YES];
            NSLog(@"播放");
            break;
        case MPMoviePlaybackStateStopped:
            //注意：正常播放完成，是不会触发MPMoviePlaybackStateStopped事件的。
            //调用[self.player stop];方法可以触发此事件。
            NSLog(@"停止");
            break;
        default:
            break;
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
