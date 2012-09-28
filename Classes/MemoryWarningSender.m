//
//  MemoryWarningSender.m
//  MemoryWarningSender
//
//  Created by Morishita Ken on 12/03/28.
//  Copyright (c) 2012年 株式会社ゆめみ. All rights reserved.
//

#import "MemoryWarningSender.h"
#import <objc/objc-class.h>

#define MemoryWarningSender_USERDEFAULTS_REPEAT_SEC (@"MemoryWarningSender_USERDEFAULTS_REPEAT_SEC")

@interface MemoryWarningSender()
- (NSMenuItem *)createMenuItem:(NSString *)title tag:(MemoryWarningMenuItem)tag;
- (void)installMenu;
- (void)sendMemoryWarning:(id)arg1;
- (int)loadDefaultRepeatTag;
@end

@implementation MemoryWarningSender
@synthesize menu=menu_;

+ (void)load
{
    NSLog(@"%s: *************************************************************", __FUNCTION__);
//    Class class = objc_getClass("MonitorController");
    //[class swizzleMethod:@selector(simulateMemoryWarning:) withMethod:@selector(simulateMemoryWarningCapture:)];
    MemoryWarningSender *mws = [[MemoryWarningSender alloc] init];
    [mws installMenu];
    
    NSLog(@"%s END", __FUNCTION__);
}

- (id)init
{
    self = [super init];
    repeatSec_ = 0;
    return self;
}

- (NSMenuItem *)createMenuItem:(NSString *)title tag:(MemoryWarningMenuItem)tag
{
    NSMenuItem *item = [[[NSMenuItem alloc] init] autorelease];
    item.title = title;
    item.tag = tag;
    item.target = self;
    item.action = @selector(action:);
    return item;
}

- (void)installMenu
{
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"jp.co.yumemi.rd.MemoryWarningSender"];
    NSMenu *menu = [[[NSMenu alloc] init] autorelease];
    [menu addItem:[self createMenuItem:NSLocalizedStringFromTableInBundle(@"None", nil, bundle, @"None") tag:MemoryWarningMenuItem_None]];
    [menu addItem:[self createMenuItem:NSLocalizedStringFromTableInBundle(@"Every 5 sec", nil, bundle, @"Every5sec") tag:MemoryWarningMenuItem_5sec]];
    [menu addItem:[self createMenuItem:NSLocalizedStringFromTableInBundle(@"Every 15 sec", nil, bundle, @"Every15sec") tag:MemoryWarningMenuItem_15sec]];
    [menu addItem:[self createMenuItem:NSLocalizedStringFromTableInBundle(@"Every 60 sec", nil, bundle, @"Every60sec") tag:MemoryWarningMenuItem_60sec]];
    self.menu = menu;
    // select defaults
    int tag = [self loadDefaultRepeatTag];
    for (NSMenuItem *item in [self.menu itemArray]) {
        if (item.tag == tag) {
            [self action:item];
        }
    }
    //
    NSMenu *appMenu = [[[[NSApplication sharedApplication] mainMenu] itemAtIndex:3] submenu];
    NSMenuItem *appMenuItem = [[[NSMenuItem alloc] init] autorelease];
    appMenuItem.title = NSLocalizedStringFromTableInBundle(@"Send MemoryWarning Repeatedly", nil, bundle, @"MenuName");
    [appMenu addItem:appMenuItem];
    [appMenu setSubmenu:menu forItem:appMenuItem];
}

- (void)action:(id)arg1
{
    NSLog(@"%s: %@", __FUNCTION__, arg1);
    for (NSMenuItem *item in [self.menu itemArray]) {
        item.state = NSOffState;
    }
    NSMenuItem *item = (NSMenuItem *)arg1;
    item.state = NSOnState;
    int nextRepeatSec = 0;
    switch (item.tag) {
        case MemoryWarningMenuItem_None:
            nextRepeatSec = 0;
            break;
        
        case MemoryWarningMenuItem_5sec:
            nextRepeatSec = 5;
            break;
        
        case MemoryWarningMenuItem_15sec:
            nextRepeatSec = 15;
            break;
            
        case MemoryWarningMenuItem_60sec:
            nextRepeatSec = 60;
            break;
            
        default:
            break;
    }
    if (repeatSec_ > 0) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
    repeatSec_ = nextRepeatSec;
    if (nextRepeatSec > 0) {
        [self performSelector:@selector(sendMemoryWarning:) withObject:arg1 afterDelay:repeatSec_];
    }
    // save to UserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:item.tag forKey:MemoryWarningSender_USERDEFAULTS_REPEAT_SEC];
}

- (int)loadDefaultRepeatTag
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (int)[defaults integerForKey:MemoryWarningSender_USERDEFAULTS_REPEAT_SEC];
}

- (void)sendMemoryWarning:(id)arg1
{
    Class class = objc_getClass("MonitorController");
    [[class sharedInstance] performSelector:@selector(simulateMemoryWarning:) withObject:arg1];
    if (repeatSec_ > 0) {
        [self performSelector:@selector(sendMemoryWarning:) withObject:arg1 afterDelay:repeatSec_];
    }
}

@end
