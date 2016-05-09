//
//  NetworkHelper.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/11.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetworkHelper : NSObject
+ (void)JsonDataWithUrl:(NSString *)url success:(void(^)(id data))success fail:(void(^)())fail view:(UIView *)view  parameters:(NSDictionary *)parameters;
@end
