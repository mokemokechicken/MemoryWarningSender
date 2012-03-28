//
//  NSObject+MonitorControllerExtention.m
//  MemoryWarningSender
//
//  Created by Morishita Ken on 12/03/28.
//  Copyright (c) 2012年 株式会社ゆめみ. All rights reserved.
//

#import "NSObject+MonitorControllerExtention.h"

@implementation NSObject (MonitorControllerExtention)
- (void)simulateMemoryWarningCapture:(id)arg1
{
    NSLog(@"%s: arg1=%@", __FUNCTION__, arg1);
    [self simulateMemoryWarningCapture:arg1];
}
@end
