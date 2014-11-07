//
//  AppDelegate.h
//  TodoList
//
//  Created by Francisco on 11/5/14.
//  Copyright (c) 2014 GoGu Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger intRow;
    NSInteger intKindItem;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger intRow;
@property (nonatomic, assign) NSInteger intKindItem;

@end

