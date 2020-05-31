//
//  ViewController.m
//  Snake
//
//  Created by vector on 2020/5/30.
//  Copyright © 2020 haoqi. All rights reserved.
//

#import "ViewController.h"
#import <Carbon/Carbon.h>
#include "Logic.h"

const static unichar UnicharUp = 0x18;
const static unichar UnicharDown = 0x19;
const static unichar UnicharLeft = 0x1b;
const static unichar UnicharRight = 0x1a;


@interface ViewController ()

@property (nonatomic, assign) enum Direction dir;

@property (nonatomic, assign) BOOL isRunning;

@property (nonatomic, assign) Logic_t * logic;

@property (nonatomic, assign) uint32_t food;
@property (nonatomic, assign) uint32_t time;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) NSArray<NSView *> * items;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSTimer * timer = [NSTimer timerWithTimeInterval:0.25 repeats:true block:^(NSTimer * _Nonnull timer) {
        [self onTimerAction];
    }];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSView * container = [[NSView alloc] initWithFrame:CGRectMake(40, 40, 410, 410)];
    container.wantsLayer = true;
    container.layer.borderColor = [NSColor lightGrayColor].CGColor;
    container.layer.borderWidth = 4;
    [self.view addSubview:container];
    
    NSMutableArray<NSView *> * items = [NSMutableArray array];
    for (NSInteger i=0; i<40; i++) {
        for (NSInteger j=0; j<40; j++) {
            NSView * item = [[NSView alloc] initWithFrame:CGRectMake(5 + 10 * j, 5 + 10 * i, 10, 10)];
            item.wantsLayer = true;
            item.layer.borderColor = [NSColor grayColor].CGColor;
            item.layer.borderWidth = 1;
            [container addSubview:item];
            [items addObject:item];
        }
    }
    self.items = items;
    
    
    [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull aEvent) {
            [self keyDown:aEvent];
            return aEvent;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isRunning = true;
        SnakeStart(self.logic);
    });

//    Logic_t logic = {};
//    logic.width = 40;
//    logic.height = 40;
//    logic.world = malloc(40 * 40 * sizeof(int32_t));
//    logic.length = 1;
//    logic.body = malloc(40 * 40 * sizeof(int32_t));
//    logic.body[0] = 40 * 20 + 20;
//    logic.world[logic.body[0]] = RectStateBody;
    
    _logic = SnakeCreate(40, 40);
}

- (void)onTimerAction {
    if (!self.isRunning) {
        return;
    }
    self.time += 1;
    if (self.time % 4 == 0) {
        
        [self go];
    }
}

- (void)go {
//    if (self.dir % 2 != self.currentDir % 2) {
//        self.currentDir = self.dir;
//    }
    
    int result = SnakeGo(self.logic, self.dir);
    
    //返回1时表示食物被吃掉了, 返回0继续， 返回-1表示蛇死了
    if (result > 0) {
        [self refresh];
    } else if (result == 0) {
        [self refresh];
    } else if (result < 0) {
        self.isRunning = false;
    }
    
}

- (void)refresh {
    int32_t * world = self.logic->world;
    [self.items enumerateObjectsUsingBlock:^(NSView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        int32_t sstate = world[idx];
        enum RectState state = sstate;
        
        switch (state) {
            case RectStateFood: {
                view.layer.backgroundColor = [NSColor greenColor].CGColor;
            }
                break;
            case RectStateBody: {
                view.layer.backgroundColor = [NSColor blackColor].CGColor;
            }
                break;
            default: {
                view.layer.backgroundColor = [NSColor clearColor].CGColor;
            }
                break;
        }
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)keyDown:(NSEvent *)event {
    NSString *chars = [event characters];
    if (chars.length > 2) {
        return;
    }
    NSLog(@"%@", chars);
    event.keyCode;

    
    if (kVK_LeftArrow == event.keyCode) {
        self.dir = DirectionLeft;
        NSLog(@"left");

    } else if (kVK_RightArrow == event.keyCode) {
        self.dir = DirectionRight;
        NSLog(@"right");

        
    } else if (kVK_DownArrow == event.keyCode) {
        self.dir = DirectionDown;

        NSLog(@"down");

    } else if (kVK_UpArrow == event.keyCode) {
        self.dir = DirectionUp;

        NSLog(@"up");

    }
    
//    for (NSInteger i=0; i<chars.length; i++) {
//        unichar ch = [chars characterAtIndex:i];
//
//        if (ch == UnicharUp) {
//            NSLog(@"上");
//        } else if (ch == UnicharDown) {
//            NSLog(@"down");
//        } else if (ch == UnicharLeft) {
//            NSLog(@"left");
//        } else if (ch == UnicharRight) {
//            NSLog(@"right");
//        }
//    }
    
    [super keyDown:event];
}


@end
