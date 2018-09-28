//
//  HCFavoriteIconModel.m
//  HCSpringBoard
//
//  Created by 刘海川 on 16/3/4.
//  Copyright © 2016年 Haichuan Liu. All rights reserved.
//

#import "HCFavoriteIconModel.h"
#import "NSObject+YYModel.h"

@implementation HCFavoriteIconModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"image" : @"kImage",
             @"name" : @"kNodeName",
             @"desc" : @"kNodeDesc",
             @"url" : @"kNodeUrl",
             @"display" : @"kIsDisplay",
             @"isReadOnly" : @"kIsReadOnly",
             @"isNeedLogin" : @"kNeedLogin",
             @"nodeIndex" : @"kNodeIndex",
             @"type" : @"kNodeType",
             @"itemList" : @"kItems"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"itemList" : HCFavoriteIconModel.class};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}

- (NSUInteger)hash {
    return [self modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}


@end
