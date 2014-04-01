//
//  main.m
//  PrintNotifications
//
//  Created by Aleksey Kononov on 3/13/14.
//  Copyright (c) 2014 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Listener : NSObject
@property (nonatomic, assign) BOOL working;
@end

@implementation Listener

- (void)didReceiveNotification:(NSNotification *)notification
{
  NSLog(@"%@", notification);
}

@end

int main(int argc, const char * argv[])
{
  @autoreleasepool {
    Listener *listener = [[Listener alloc] init];
    listener.working = YES;
    [[NSDistributedNotificationCenter defaultCenter] addObserver:listener
                                                        selector:@selector(didReceiveNotification:)
                                                            name:nil
                                                          object:nil
                                              suspensionBehavior:4];

    while (listener.working) {
      CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.1, YES);
    }
  }
  return 0;
}