//
//  MemoryWarningSender.h
//  MemoryWarningSender
//
//  Created by Morishita Ken on 12/03/28.
//  Copyright (c) 2012年 株式会社ゆめみ. All rights reserved.
//

//A#import <UIKit/UIKit.h>

typedef enum {
    MemoryWarningMenuItem_None = 1,
    MemoryWarningMenuItem_5sec = 2,
    MemoryWarningMenuItem_15sec = 3,
    MemoryWarningMenuItem_60sec = 4
} MemoryWarningMenuItem;

@interface MemoryWarningSender : NSObject
{
    NSMenu *menu_;
    int repeatSec_;
}

@property (nonatomic, retain) NSMenu *menu;
@end
