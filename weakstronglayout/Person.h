//
//  Person.h
//  weakstronglayout
//
//  Created by zhaoyan on 2018/12/4.
//  Copyright © 2018 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

{
    __strong id name;
    __weak id a;
    __unsafe_unretained id c; //不计算在 weak layout
    int g; //不计算在weak layout
    __strong id h;
    // _autoreleasing 不支持
    //__autoreleasing id j;
    
}

@end

NS_ASSUME_NONNULL_END
