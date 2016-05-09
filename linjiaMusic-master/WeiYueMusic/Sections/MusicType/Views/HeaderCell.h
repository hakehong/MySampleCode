//
//  HeaderCell.h
//  WeiYueMusic
//
//  Created by hongqing on 15/7/10.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblSongCount;
@property (weak, nonatomic) IBOutlet UIImageView *listBgkImage;

@property (nonatomic, strong) NSDictionary *userDict;
@end
