//
//  ViewController.m
//  weakstronglayout
//
//  Created by zhaoyan on 2018/12/4.
//  Copyright © 2018 baidu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#import <objc/runtime.h>

@interface ViewController()
@end

@implementation ViewController

- (NSMutableIndexSet *)ivarLayout:(const uint8_t *)strongLayout {
    NSMutableIndexSet *layout = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    
    while (*strongLayout != '\x00') {
        //非strong
        uint8_t upper = (*strongLayout & 0xf0) >> 4;
        
        //strong
        uint8_t lower = (*strongLayout & 0x0f);
        
        //得到strong引用的初始index
        index += upper;
        
        //将strong的index，并且放在layout中
        [layout addIndexesInRange:NSMakeRange(index, lower)];
        
        //将index指向最后一位strong引用
        index += lower;
        
        //指针+1
        strongLayout ++;
    }
    return layout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    const uint8_t *weakLayout = class_getWeakIvarLayout(Person.class);
    NSMutableIndexSet * layout = [self ivarLayout:weakLayout];
    [layout enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index: %zd", idx);
    }];
    
    
    const uint8_t *strongLayout = class_getIvarLayout(Person.class);
    layout = [self ivarLayout:strongLayout];
    [layout enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"index: %zd", idx);
    }];
}


@end
