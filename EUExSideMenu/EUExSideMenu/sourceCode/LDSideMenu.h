//
//  LDSideMenu.h
//  AppCanPlugin
//  参考了HMSideMenu,做了封装
//  Created by Frank on 15/1/19.
//  Copyright (c) 2015年 zywx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LDSideMenuPositionLeft,
    LDSideMenuPositionRight,
    LDSideMenuPositionTop,
    LDSideMenuPositionBottom
} LDSideMenuPosition;
@interface LDSideMenu : UIView

@property (nonatomic, assign, readonly) BOOL isOpen;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, assign) LDSideMenuPosition menuPosition;
- (id)initWithItems:(NSArray *)items;
- (void)open;
- (void)close;
@end

@interface UIView (MenuActionHandlers)

- (void)setMenuActionWithBlock:(void (^)(void))block;
@end