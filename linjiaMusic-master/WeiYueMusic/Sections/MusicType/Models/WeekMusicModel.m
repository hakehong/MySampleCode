//
//  WeekMusicModel.m
//  WeiYueMusic
//
//  Created by hongqing on 15/7/13.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import "WeekMusicModel.h"

@implementation WeekMusicModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
@end
