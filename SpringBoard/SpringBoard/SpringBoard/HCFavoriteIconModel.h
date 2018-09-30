//
//  HCFavoriteIconModel.h
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCFavoriteIconModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) BOOL display;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isReadOnly;
@property (nonatomic, assign) BOOL isNeedLogin;

@property (nonatomic, copy) NSString *nodeIndex;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSArray *itemList;

@property (nonatomic, assign) BOOL isAddToPage;

@end
