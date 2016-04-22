//
//  ViewController.m
//  SavePhoto
//
//  Created by hongqing on 16/4/20.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)click:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
     UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle: UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
        //设置数据源，图片显示的来源是什么，可以是相机、照片薄、或者图片库
        
        picker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //设置的代理
        
//        picker.delegate = self;
        
        // model出相册的控制器的View
        
        [self presentViewController:picker animated:YES completion:nil];
        NSLog(@"点击成功");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}
- (IBAction)click:(UIButton *)sender {
    UIImageWriteToSavedPhotosAlbum(self.image.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);

   
}
@end
