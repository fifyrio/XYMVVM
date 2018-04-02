//
//  NSObject+XYSwizzle.m
//  Demo
//
//  Created by Will on 2018/3/27.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "NSObject+XYSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (XYSwizzle)

- (void)xy_swizzlingOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    NSObjectSwizzlingSelector(self, originalSelector, swizzledSelector);
    
}

static void NSObjectSwizzlingSelector(NSObject *self,SEL originalSelector, SEL swizzledSelector){
    Class class = self.class;
    
    Class baseClass = object_getClass(self);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


@end
