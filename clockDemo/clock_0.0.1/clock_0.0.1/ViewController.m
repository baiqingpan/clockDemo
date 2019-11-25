//
//  ViewController.m
//  clock_0.0.1
//
//  Created by baiqing.pan on 2019/11/20.
//  Copyright © 2019 person. All rights reserved.
//
#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface ViewController ()
{
    CGFloat angle ;
    CGFloat angleMin ;
    CGFloat angleHour ;
}
@end

@implementation ViewController
- (void) viewDidLoad
{
    //创建根视图
    [super viewDidLoad];
    NSView * view = [[NSView alloc]initWithFrame:NSMakeRect(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
    view.wantsLayer = true;
    view.layer.backgroundColor = [NSColor greenColor].CGColor;
    [self.view addSubview:view];
    //加入背景表盘
    NSString *imageName = [[NSBundle mainBundle] pathForResource:@"666" ofType:@"png"];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:imageName];
    NSImageView *imageView = [[NSImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    //创建时分秒针
    [self createHourView];
    [imageView addSubview:_hourView];
    [self createMinView];
    [imageView addSubview:_minView];
    [self createSecondView];
    [imageView addSubview:_secondView];
    //刷新view
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void) move
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"move called start");
        //计算时分秒针的移动角度
        float secsAngle = 6;
        float minsAngle = 6;
        float hoursAngle = 30;
        //获取当前时间
        NSDate *date = [NSDate date];
        NSCalendar *calender = [NSCalendar currentCalendar];
        NSInteger secs = [calender component:NSCalendarUnitSecond
                                    fromDate:date];
        NSInteger mins = [calender component:NSCalendarUnitMinute
                                    fromDate:date];
        NSInteger hours = [calender component:NSCalendarUnitHour
                                     fromDate:date];
        //计算当前时分秒针所在位置
        self->angle = -secs * secsAngle;
        self->angleMin = -mins * minsAngle - self->angle/60;
        self->angleHour = -hours * hoursAngle - self->angleMin/60;
        //让时分秒针旋转
        [[self.secondView animator] setFrameRotation:self->angle];
        [[self.minView animator] setFrameRotation:self->angleMin];
        [[self.hourView animator] setFrameRotation:self->angleHour];
        NSLog(@"move called end");
    });
}

- (void) createSecondView
{
    NSView *secondView = [[NSView alloc]initWithFrame:CGRectMake(0, 0, 2, 60)];
    secondView.wantsLayer = true;
    secondView.frame = NSMakeRect(self.view.frame.size.width/2+3,self.view.frame.size.height/2, 2, 70);
    secondView.layer.anchorPoint = CGPointMake(0.5,0.9);
    secondView.layer.backgroundColor = [NSColor redColor].CGColor;
    self.secondView = secondView;
}

- (void) createMinView
{
    NSView *minView = [[NSView alloc]initWithFrame:CGRectMake(0,0,3,60)];
    minView.wantsLayer = true;
    minView.frame = NSMakeRect(self.view.frame.size.width/2+3,self.view.frame.size.height/2,3,50);
    minView.layer.anchorPoint = CGPointMake(0.5,0.9);
    minView.layer.backgroundColor = [NSColor blueColor].CGColor;
    self.minView=minView;
}

- (void) createHourView
{
    NSView *hourView = [[NSView alloc]initWithFrame:CGRectMake(0,0,4,30)];
    hourView.wantsLayer = true;
    hourView.frame = NSMakeRect(self.view.frame.size.width/2+3,self.view.frame.size.height/2,4,30);
    hourView.layer.anchorPoint = CGPointMake(0.5,0.9);
    hourView.layer.backgroundColor = [NSColor blackColor].CGColor;
    self.hourView = hourView;
}

@end
