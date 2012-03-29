//
//  NSObject+Swizzle.m
//  MemoryWarningSender
//
//  Created by Morishita Ken on 12/03/28.
//  Copyright (c) 2012年 株式会社ゆめみ. All rights reserved.
//

/*
    http://mitukiii.jp/2011/01/21/how-to-make-simbl-plugin/
    のコードを使わせて頂いています。
*/

#import "NSObject+Swizzle.h"
#import <objc/objc-class.h>


@implementation NSObject (Swizzle)

+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel
{
    Method orig_method = class_getInstanceMethod(self, orig_sel);
    Method alt_method = class_getInstanceMethod(self, alt_sel);
    
    if (orig_method == nil || alt_method == nil) {
        NSLog(@"method not exists.");
        return;
    }
    
    class_addMethod(self,
                    orig_sel,
                    class_getMethodImplementation(self, orig_sel),
                    method_getTypeEncoding(orig_method));
    
    class_addMethod(self,
                    alt_sel,
                    class_getMethodImplementation(self, alt_sel),
                    method_getTypeEncoding(alt_method));
    
    method_exchangeImplementations(class_getInstanceMethod(self, orig_sel), class_getInstanceMethod(self, alt_sel));
}


@end
