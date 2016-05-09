//
//  PlayRecordEntity.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/17.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PlayRecordEntity : NSManagedObject

@property (nonatomic, retain) NSString * songName;
@property (nonatomic, retain) NSString * songPlayCount;
@property (nonatomic, retain) NSString * songImage;
@property (nonatomic, retain) NSString * songUrl;
@property (nonatomic, retain) NSString * songFrom;
@property (nonatomic, retain) NSString * songSinger;
@property (nonatomic, retain) NSString * songID;
@property (nonatomic) int32_t autoID;

@end
