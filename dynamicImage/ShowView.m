
//
//  ShowView.m
//  dynamicImage
//
//  Created by gaoguangxiao on 2018/8/9.
//  Copyright © 2018年 gaoguangxiao. All rights reserved.
//

#import "ShowView.h"

@interface ShowView()

@property(nonatomic,strong)NSMutableArray *pointArr;
@property(nonatomic,strong)NSTimer *timer;
@end


@implementation ShowView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(NSMutableArray *)pointArr{
    if (!_pointArr) {
        _pointArr = [NSMutableArray new];
    }
    return _pointArr;
}

-(void)startPlayGif{
    
    

    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(updateShare) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    });
//    CADisplayLink *disPlay = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateShare)];
//    [disPlay addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)updateShare{
    
    
    
    [self.pointArr removeAllObjects];
    
    NSInteger count = self.frame.size.width / 3;
    NSInteger height = self.frame.size.height;
    for (NSInteger i = 0; i < count; i++) {
        [self.pointArr addObject:@(arc4random()%height)];
    }
    
    [self setNeedsDisplay];
}

//柱形
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.pointArr||[self.pointArr count] == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    float channelCenterY = self.frame.size.height;//中间线是
    
    for (NSInteger i = 0; i < self.pointArr.count; i++){
        NSInteger point = [self.pointArr[i] integerValue];
        float x = i * (self.frame.size.width) / self.pointArr.count;
        CGContextMoveToPoint(context, x, channelCenterY - point);
        CGContextAddLineToPoint(context, x, channelCenterY);//
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:240/255.0 green:70255.0 blue:135255.0 alpha:1.0].CGColor);
        CGContextStrokePath(context);
    }
    
}
@end
