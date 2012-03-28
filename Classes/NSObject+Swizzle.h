//
//  NSObject+Swizzle.h
//  MemoryWarningSender
//
//  Created by Morishita Ken on 12/03/28.
//  Copyright (c) 2012年 株式会社ゆめみ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)
+ (void)swizzleMethod:(SEL)orig_sel withMethod:(SEL)alt_sel;
@end
