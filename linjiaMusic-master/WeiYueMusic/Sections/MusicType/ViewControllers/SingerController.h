//
//  SingerController.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/13.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingerController : UIViewController
@property (nonatomic, strong) UINavigationController *navigation;
@property (nonatomic, copy) NSString *navTitle;
@property (nonatomic, strong) NSNumber *singerTypeID;
@end
