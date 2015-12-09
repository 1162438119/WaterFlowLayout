//
//  ViewController.m
//  WaterFlowLayout
//
//  Created by mac on 15/12/8.
//  Copyright (c) 2015年 dqy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WaterFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView * collecionview;

@property (nonatomic,strong) NSArray * goods;

@end

@implementation ViewController

/*
 懒加载
 */
- (NSArray *)goods {
    
    if (_goods == nil) {
        
        self.goods = [NSArray array];
    }
    
    return _goods;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     数据的加载
     */
    self.view.backgroundColor = [UIColor whiteColor];
    self.goods = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"plist"]];
    
 
    /*
     布局的初始化
     */

    WaterUICollecionViewFlowLayout * layout = [[WaterUICollecionViewFlowLayout alloc] init];
    
    layout.delegate = self;

    /*
     collectionview的初始化
     */
    self.collecionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.collecionview.delegate = self;
    
    self.collecionview.dataSource = self;
    
    self.collecionview.backgroundColor = [UIColor whiteColor];
    
    [self.collecionview registerClass:[WaterCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    [self.view addSubview:self.collecionview];

    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark -------------- collection datasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    Goods * goods = [[Goods alloc] initWithDic: self.goods[indexPath.item]];
    
    [cell getImage:goods.image width:goods.width height:goods.height];
    
    
    return cell;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.goods.count;
}




#pragma mark ------------------- water delegate

- (CGFloat)waterFlowLayout:(WaterUICollecionViewFlowLayout *)waterFlowLayout heightForItemIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    
    Goods * goods = [[Goods alloc] initWithDic:self.goods[indexPath.item]];
    
    return goods.height * itemWidth / goods.width;

    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
