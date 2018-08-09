//
//  ViewController.m
//  dynamicImage
//
//  Created by gaoguangxiao on 2018/8/9.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ViewController.h"

#import "ShowView.h"
@interface ViewController ()
{
    __weak IBOutlet ShowView *s;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //一、dispatch_sync(dispatch_get_main_queue())死锁原因
//    https://www.2cto.com/kf/201507/415322.html
//    1、dispatch_sync在等待block语句执行完成，而block语句需要在主线程执行，所以dispatch_sync如果在主线程调用就会死锁
//    2、dispatch_sync是同步的，本身就会阻塞当前线程，也就是主线程，而又往主线程塞进去一个block
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"1");
            });
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"1.0");
    //打印不出来

//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"1.1");
//    });
//    });
    NSLog(@"2");
}
- (IBAction)PlayGif:(id)sender {
    
    [s startPlayGif];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
