//
//  AppDelegate.m
//  WeiYueMusic
//
//  Created by hongqing on 15/7/10.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "AVFoundation/AVFoundation.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate ()
@property(nonatomic,assign)UIBackgroundTaskIdentifier *bgTaskId;
@end

@implementation AppDelegate

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPreviousTrack:
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                break;
            case UIEventSubtypeRemoteControlPlay:
                break;
            case UIEventSubtypeRemoteControlPause:
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                break;
            default:
                break;
        }
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
#pragma mark --添加锁屏、控制中心喜欢按钮
    [self updateLrcLineLabelForScrollView];
    return YES;
}
// 在锁屏界面显示歌曲信息(实时换图片MPMediaItemArtwork可以达到实时换歌词的目的)
- (void)updateLrcLineLabelForScrollView
{
    // 如果存在这个类,才能在锁屏时,显示歌词
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        // 核心:字典
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        
        // 标题(音乐名称)
        info[MPMediaItemPropertyTitle] = @"标题(音乐名称)";
        // 艺术家
        info[MPMediaItemPropertyArtist] = @"艺术家";
        // 专辑名称
        info[MPMediaItemPropertyAlbumTitle] = @"专辑名称";
        
        //设置当前时间
        info[MPNowPlayingInfoPropertyElapsedPlaybackTime]=@(1);
        
        //总时间
        info[MPMediaItemPropertyPlaybackDuration]= @(20);
        
        // 图片
        info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"default.jpg"]];
        //        info[MPMediaItemPropertyArtwork] = [MPMediaItemPropertyArtwork  sd_setImageWithURL:[NSURL URLWithString:_pic_url] placeholderImage:[UIImage imageNamed:@"default.jpg"]];
        // 唯一的API,单例,nowPlayingInfo字典
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
    }
    
    
    //主屏显示
    MPRemoteCommandCenter *rcc = [MPRemoteCommandCenter sharedCommandCenter];
    
    
//    MPSkipIntervalCommand *skipBackwardIntervalCommand = [rcc skipBackwardCommand];
//    [skipBackwardIntervalCommand setEnabled:YES];
//    [skipBackwardIntervalCommand addTarget:self action:@selector(skipBackwardEvent)];
    
//    MPSkipIntervalCommand *skipForwardIntervalCommand = [rcc skipForwardCommand];
//    [skipForwardIntervalCommand setEnabled:YES];
//    [skipForwardIntervalCommand addTarget:self action:@selector(skipForwardEvent)];
//    
    
    
     // Doesn’t show unless prevTrack is enabled
//     MPRemoteCommand *seekBackwardCommand = [rcc seekBackwardCommand];
//     [seekBackwardCommand setEnabled:NO];
//     [seekBackwardCommand addTarget:self action:@selector(seekEvent:)];
    
//      Doesn’t show unless nextTrack is enabled
     MPRemoteCommand *seekForwardCommand = [rcc seekForwardCommand];
     [seekForwardCommand setEnabled:NO];
     [seekForwardCommand addTarget:self action:@selector(seekEvent:)];
    
    
    //收藏按钮
    MPFeedbackCommand *likeCommand = [rcc likeCommand];
    [likeCommand setEnabled:YES];
    [likeCommand setLocalizedTitle:@"喜欢"];  // can leave this out for default
    [likeCommand addTarget:self action:@selector(likeEvent)];
    
    //取消按钮
    MPFeedbackCommand *dislikeCommand = [rcc dislikeCommand];
    [dislikeCommand setEnabled:YES];
//    [dislikeCommand setActive:YES]; //显示勾勾
    [dislikeCommand setLocalizedTitle:@"上一首"]; // can leave this out for default
    [dislikeCommand addTarget:self action:@selector(lastSongEvent)];
    
    //添加按钮
//    MPFeedbackCommand *bookmarkCommand = [rcc bookmarkCommand];
//    [bookmarkCommand setEnabled:YES];
//    [bookmarkCommand setActive:YES];
//    [bookmarkCommand setLocalizedTitle:@"加我加我"]; // can leave this out for default
//    [bookmarkCommand addTarget:self action:@selector(bookmarkEvent)];
    
}

//-(void)skipBackwardEvent
//{
//    NSLog(@"skipBackwardEvent");
//}

-(void)skipForwardEvent
{
    NSLog(@"skipForwardEvent");
}

-(void)seekEvent:(UIEvent *)event
{
    NSLog(@"event=%@",event);
}


-(void)likeEvent
{
    NSLog(@"我是收藏");
}

-(void)lastSongEvent
{
    NSLog(@"切换到上一首歌曲");
}

-(void)bookmarkEvent
{
    NSLog(@"加我加我");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}
-(void)applicationWillResignActive:(UIApplication *)application
{
    //开启后台处理多媒体事件
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    _bgTaskId=[AppDelegate backgroundPlayerID:_bgTaskId];
    //其中的_bgTaskId是后台任务UIBackgroundTaskIdentifier _bgTaskId;
}
//实现一下backgroundPlayerID:这个方法:
+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId
{
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hongqing.ashen.WeiYueMusic" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WeiYueMusic" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WeiYueMusic.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark 网络判断
- (void)judgeNetworking {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (AFNetworkReachabilityStatusNotReachable == status) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络你别走"
                                                            message:@"木牛网络是多么痛的领悟!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"拜拜" otherButtonTitles:nil];
            [alert show];
        }
        
    }];
    
}

@end
