//
//  WaterUICollecionViewFlowLayout.h
//  WaterFlowLayout
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterUICollecionViewFlowLayout;


@protocol WaterFlowLayoutDelegate <NSObject>
/*
 查询单元格的高度
 */
- (CGFloat)waterFlowLayout:(WaterUICollecionViewFlowLayout *) waterFlowLayout heightForItemIndexPath:(NSIndexPath *) indexPath itemWidth:(CGFloat) itemWidth;


@optional

/*
 返回单元格四边的间距  默认（10，10，10，10）
 */
- (UIEdgeInsets)insetsInWaterFlowLayout:(WaterUICollecionViewFlowLayout *) waterFlowLayout;

/*
 返回最大列数 默认2
 
 */
- (NSInteger)maxColInWaterFlowLayout:(WaterUICollecionViewFlowLayout *) waterFlowLayout;

/*
 返回每行的间距 默认是10
 */
- (CGFloat)lineSpacingInWaterFlowLayout:(WaterUICollecionViewFlowLayout *) waterFlowLayout;

/*
 返回单元格的间距 默认是10
 */
- (CGFloat)itemSpacingInWaterFlowLayout:(WaterUICollecionViewFlowLayout *) waterFlowLayout;

@end

@interface WaterUICollecionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,assign) id<WaterFlowLayoutDelegate> delegate;
@end


