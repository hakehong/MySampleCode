//
//  ViewController.h
//  addressList
//
//  Created by hongqing on 16/3/4.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LBAddressBookVC : UIViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSMutableArray *personArray;
@end
