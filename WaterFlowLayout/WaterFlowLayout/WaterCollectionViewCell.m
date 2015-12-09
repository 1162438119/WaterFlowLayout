//
//  WaterCollectionViewCell.m
//  WaterFlowLayout
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import "WaterCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@interface WaterCollectionViewCell ()
{
    UIImageView * _imageview;
}
@end

@implementation WaterCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _imageview = [[UIImageView alloc] init];
        
        [self.contentView addSubview:_imageview];
    }
    return self;
}


- (void)getImage:(NSString *)imageurl width:(float)width height:(float)height {
    
    _imageview.image = nil;
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    
    _imageview.frame = self.bounds;
    
    
}


@end
