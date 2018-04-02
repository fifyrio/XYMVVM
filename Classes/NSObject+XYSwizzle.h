//
//  NSObject+XYSwizzle.h
//  Demo
//
//  Created by Will on 2018/3/27.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XYSwizzle)

- (void)xy_swizzlingOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
