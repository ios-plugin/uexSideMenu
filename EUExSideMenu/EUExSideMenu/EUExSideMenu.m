//
//  EUExSideMenu.m
//  AppCanPlugin
//
//  Created by Frank on 15/1/19.
//  Copyright (c) 2015年 zywx. All rights reserved.
//

#import "EUExSideMenu.h"
#import "LDSideMenu.h"
#import "JSON.h"
//#import "UIView+Helpers.h"
#import "EUtility.h"
@interface EUExSideMenu()
@property(nonatomic,strong)LDSideMenu *sideMenu;
@property(nonatomic,assign)CGPoint positionPoint;
@end
@implementation EUExSideMenu
-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
    }
    return self;
}

-(void)open:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
        CGFloat x = [[array objectAtIndex:0] floatValue];
        CGFloat y = [[array objectAtIndex:1] floatValue];
        self.positionPoint = CGPointMake(x, y);
    }
    if (![self.sideMenu isOpen]) {
        [self.sideMenu open];
    }
    
}
-(void)setItems:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
        NSString *jsonString = [array firstObject];
        NSDictionary *inDict = [jsonString JSONValue];
        NSArray *inMenuList = [inDict objectForKey:@"menuItems"];
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:inMenuList.count];
        for(int i = 0; i < inMenuList.count;i++){
            NSDictionary *itemDict = [[inMenuList objectAtIndex:i] objectForKey:@"item"];
            NSString *bgImgPath = [EUtility getAbsPath:self.meBrwView path:itemDict[@"bgImg"]];
            UIImage *bgImg = [UIImage imageWithContentsOfFile:bgImgPath];
            
            NSString *itemPath = [EUtility getAbsPath:self.meBrwView path:itemDict[@"buttonImg"]];
            UIImage *itemImage = [UIImage imageWithContentsOfFile:itemPath];
            
            UIImageView *itemBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,100, 45)];
            [itemBg setUserInteractionEnabled:YES];
            [itemBg setImage:bgImg];
            [itemBg setMenuActionWithBlock:^{
                [self menuItemClick:i];
            }];
            UIImageView *itemView = [[UIImageView alloc] initWithFrame:CGRectMake(57,2, 41, 41)];
            [itemView setImage:itemImage];
            [itemBg addSubview:itemView];
            [itemView release];
            [itemArray addObject:itemBg];
            [itemBg release];
        }
        if (itemArray.count > 0) {
            if (self.sideMenu == nil) {
                LDSideMenu *sideMenu = [[LDSideMenu alloc] initWithItems:itemArray];
                [sideMenu setMenuPosition:LDSideMenuPositionLeft];
                [sideMenu setItemSpacing:20.0f];
                [EUtility brwView:meBrwView addSubview:sideMenu];
                
                self.sideMenu = sideMenu;
                [sideMenu release];
            }
            
        }
    }

    
}
-(void)close:(NSMutableArray *)array{
    if (self.sideMenu&&self.sideMenu.isOpen){
        [self.sideMenu close];
    }
}
-(void)menuItemClick:(int)index{
    [self.meBrwView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"uexSideMenu.onItemClick(%d);",index]];
}
-(void)clean{
    if (self.sideMenu) {
        [self.sideMenu removeFromSuperview];
        self.sideMenu = nil;
    }
}
@end
