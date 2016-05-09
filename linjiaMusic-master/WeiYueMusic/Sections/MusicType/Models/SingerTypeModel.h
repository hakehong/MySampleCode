//
//  SingerTypeModel.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/13.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingerTypeModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, copy) NSString *title, *details;
@property (nonatomic, copy) NSString *pic_url, *time;
@property (nonatomic, strong) NSNumber *count;
@end
