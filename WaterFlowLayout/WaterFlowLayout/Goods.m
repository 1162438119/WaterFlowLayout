//
//  Goods.m
//  WaterFlowLayout
//
//  Created by mac on 15/12/9.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import "Goods.h"

@implementation Goods

- (instancetype)initWithDic:(NSDictionary *)dic {
    
    
    if (self = [super init]) {
        
        self.width = [dic[@"w"] floatValue];
        self.height = [dic[@"h"] floatValue];
        self.image = dic[@"img"];
    }
    
    return self;
}

@end
