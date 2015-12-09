//
//  WaterUICollecionViewFlowLayout.m
//  WaterFlowLayout
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import "WaterUICollecionViewFlowLayout.h"
/*
 默认的数据
 */
const UIEdgeInsets defaultInsets = {10,10,10,10};

const NSInteger defaultMaxCol = 2;

const CGFloat defaultLineSpacing = 10;

const CGFloat defaultItemSpacing = 10;

@interface WaterUICollecionViewFlowLayout ()

//存放y值
@property (nonatomic,strong) NSMutableArray * pointYArray;

//存放布局属性
@property (nonatomic,strong) NSMutableArray * attrsArray;

@end


@implementation WaterUICollecionViewFlowLayout

//懒加载
- (NSMutableArray *)pointYArray {
    
    if (_pointYArray == nil) {
        
        self.pointYArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _pointYArray;
    
}


-(NSMutableArray *)attrsArray {
    
    if (_attrsArray == nil) {
        
        self.attrsArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _attrsArray;
    
}

/*
 
 
 
 */
- (void)prepareLayout
{
    NSLog(@"%s", __FUNCTION__);
    // 初始化最大y值数组
    [self.pointYArray removeAllObjects];
    int maxColumns = (int)[self maxCol];
    for (NSUInteger i = 0; i < maxColumns; i++) {
        [self.pointYArray addObject:@(self.insets.top)];
    }
    
   
    
    // 计算所有cell的布局属性
    [self.attrsArray removeAllObjects];
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

/*
    return YES  collecionview update layout when visible bounds change
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

/**
 * 返回collectionView的ContentSize 滚动的区域
 */
- (CGSize)collectionViewContentSize
{
    CGFloat longMaxY = 0;
    if (self.pointYArray.count) {
        longMaxY = [self.pointYArray[0] doubleValue]; // 最长那一列 的 最大Y值
        for (int i = 1; i < [self maxCol]; i++) {
            CGFloat maxY = [self.pointYArray[i] doubleValue];
            if (maxY > longMaxY) {
                longMaxY = maxY;
            }
        }
        
        // 累加底部的间距
        longMaxY += self.insets.bottom;
    }
    
    return CGSizeMake(0, longMaxY);
}


/*
 return layout for item at indexpath
 */

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat lineSpacing = [self lineSpacing];
    
    CGFloat itemSpacing = [self itemSpacing];
    
    CGFloat collecionViewWidth = self.collectionView.bounds.size.width;
    
    NSInteger maxCol = [self maxCol];
    
    UIEdgeInsets insets = [self insets];
    
    //item width
    
    CGFloat itemWidth = (collecionViewWidth - insets.left - insets.right - (maxCol - 1) * itemSpacing ) / maxCol;
    
    
    // ask delegate get itemheight
    
    CGFloat itemHeight = [self.delegate waterFlowLayout:self heightForItemIndexPath:indexPath itemWidth:itemWidth];
   
    
    UICollectionViewLayoutAttributes * itemAttrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    /*
     得到没一行每一列的的起始Y值
     
     */
    NSInteger minYNUm = 0;
    CGFloat minY = [self.pointYArray[0] floatValue];
    
    for (int i = 1; i < [self maxCol]; i++) {
        
        CGFloat tempY = [self.pointYArray[i] floatValue];
        if (tempY < minY) {
            minY = tempY;
            minYNUm = i;
        }
    }
    
    
    CGFloat itemX = insets.left + minYNUm * (itemWidth + itemSpacing);
    
    CGFloat itemY = minY + lineSpacing;
    
    itemAttrs.frame = CGRectMake(itemX, itemY , itemWidth, itemHeight);
    

    
    self.pointYArray[minYNUm] = @(CGRectGetMaxY(itemAttrs.frame));
    
    return itemAttrs;
}
/*
 
 返回每一个单元格的具体布局
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    return self.attrsArray;
}

#pragma mark ---------------------- 私有方法 获得代理的返回值
/*
 单元格的insets
 */
- (UIEdgeInsets)insets {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(insetsInWaterFlowLayout:)]) {
        
        return [self.delegate insetsInWaterFlowLayout:self];
    }
    return defaultInsets;
    
}

/*
 最大的列数
 */
- (NSInteger)maxCol {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(maxColInWaterFlowLayout:)]) {
        
        return [self.delegate maxColInWaterFlowLayout:self];
    }
    
    return defaultMaxCol;
}

/*
 行距
 */
- (CGFloat)lineSpacing {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lineSpacingInWaterFlowLayout:)]) {
        
        return [self.delegate lineSpacingInWaterFlowLayout:self];
    }
    return defaultLineSpacing;
    
}

/*
 
 间距
 */

- (CGFloat)itemSpacing {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemSpacingInWaterFlowLayout:)]) {
        return [self.delegate itemSpacingInWaterFlowLayout:self];
    }
    
    return defaultItemSpacing;
    
}




@end
