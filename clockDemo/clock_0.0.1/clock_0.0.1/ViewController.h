//
//  ViewController.h
//  clock_0.0.1
//
//  Created by baiqing.pan on 2019/11/20.
//  Copyright © 2019 person. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface ViewController : NSViewController

@property CGRect bounds;
@property CGPoint anchorPoint;
@property CGColorRef backgroundColor;
@property (nonatomic,strong) NSView *secondView;
@property (nonatomic,strong) NSView *minView;
@property (nonatomic,strong) NSView *hourView;

- (void) move;
- (void) createSecondView;
- (void) createMinView;
- (void) createHourView;
@end
