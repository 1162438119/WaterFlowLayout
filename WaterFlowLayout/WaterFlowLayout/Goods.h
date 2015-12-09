//
//  Goods.h
//  WaterFlowLayout
//
//  Created by mac on 15/12/9.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject


@property (nonatomic, assign) float width;
@property (nonatomic,assign) float height;
@property (nonatomic,copy) NSString * image;

- (instancetype)initWithDic:(NSDictionary *) dic;
@end
