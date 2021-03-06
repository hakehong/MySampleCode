//
//  MainViewController.m
//  WeiYueMusic
//
//  Created by hongqing on 15/7/10.
//  Copyright (c) 2015年 hongqing. All rights reserved.
//

#import "MainViewController.h"
#import "SwipeView.h"
#import "MusicTypeViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "AppDelegate.h"
#import "BottomPlayView.h"
#import "PlayViewController.h"
#import "MineController.h"
#import "OpenSearchController.h" 

@interface MainViewController ()<SwipeViewDataSource, SwipeViewDelegate>
@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak, nonatomic) IBOutlet UIView *moveView;

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation MainViewController

- (void)dealloc {
    //释放代理
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BottomPlayView *bpv = [BottomPlayView shareBottomPlayView];
    [self.view addSubview:bpv];
    bpv.TapPlayView = ^(NSMutableArray *dataArr, NSInteger currentIndex,
                        NSString *pic_url, AVPlayerItem *currentItem) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PlayViewController *pvc = [sb instantiateViewControllerWithIdentifier:@"sbPlayView"];
        pvc.navigation = self.navigationController;
        pvc.dataArr = dataArr;
        pvc.currentIndex = currentIndex;
        pvc.pic_url = pic_url;
        pvc.currentItem = currentItem;
        [self.navigationController pushViewController:pvc animated:YES];
    };
    [self.view bringSubviewToFront:bpv];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}
/**
 * 添加了[_swipeView reloadData];
 * 页面启动完毕后音库界面刷新，不会开始显示空白
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.hidesBarsOnSwipe = YES; //滑动隐藏
    self.fd_prefersNavigationBarHidden = YES;
    _swipeView.pagingEnabled = YES;
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    _swipeView.wrapEnabled = YES;
    [_swipeView reloadData];
    [self setupView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark - 配置swipeView视图

- (void)setupView {
    
    MusicTypeViewController *typeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"sbMusicType"];
    typeVC.navigation = self.navigationController;
    
    OpenSearchController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"sbOpenSearch"];
    
    searchVC.navigation = self.navigationController;
    MineController *mineVC = [self.storyboard instantiateViewControllerWithIdentifier:@"sbMine"];
    mineVC.navigation = self.navigationController;
    
   
    
    self.items = [NSMutableArray arrayWithObjects:typeVC, searchVC, mineVC, nil];
}


#pragma mark - button action
- (IBAction)btnSearch:(id)sender {
    _swipeView.currentItemIndex = 1;
}
- (IBAction)btnMine:(id)sender {
    _swipeView.currentItemIndex = 2;
}

- (IBAction)btnMusic:(id)sender {
    _swipeView.currentItemIndex = 0;
}



#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return _items.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    return [_items[index] view];
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView {
    
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:100 + i];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    switch (swipeView.currentItemIndex) {
        case 0:{
            [self updateLineViewFrame:0];
            break;
        }
        case 1:{
            [self updateLineViewFrame:1];
            break;
        }
        case 2: {
            [self updateLineViewFrame:2];
            break;
        }
        default:
            break;
    }
}


- (void)updateLineViewFrame:(NSInteger)index {
    CGRect frame = _moveView.frame;
    UIButton *btn = (UIButton *)[self.view viewWithTag:100 + index];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    frame.origin.x = index * ([UIScreen mainScreen].bounds.size.width / 3) + btn.frame.size.width /6;
    _moveView.frame = frame;
}



@end
