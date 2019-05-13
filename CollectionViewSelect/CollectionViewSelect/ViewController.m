//
//  ViewController.m
//  CollectionViewSelect
//
//  Created by rpweng on 2019/5/13.
//  Copyright © 2019 rpweng. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"

static NSString *const cellId = @"cellId";
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArrayM;

@property (nonatomic, weak) UICollectionView *collectionView;

// 选中cell的indexPath
@property (nonatomic, strong) NSIndexPath *selectIndexPath;
// 取消选中的cell，防止由于重用，在取消选中的代理方法中没有设置
@property (nonatomic, strong) NSIndexPath *DeselectIndexpath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"CollectionView默认选中第0个";
    self.selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self setupUICollectionView];
    
    // 设置collectionView的数据
    [self setupCollectionViewData];
}

#pragma mark - private Method
#pragma mark 设置collectionView的数据
- (void)setupCollectionViewData {
    
    for (int i = 0; i < 20; i++) {
        [self.dataArrayM addObject:[NSString stringWithFormat:@"第%d个cell",i]];
    }
    
    [self.collectionView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - setupUI
#pragma mark setupUICollectionView
- (void)setupUICollectionView {
    // 设置uicollectionView样式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArrayM count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell.nameLabel setText:self.dataArrayM[indexPath.row]];
    
    if ([self.selectIndexPath isEqual:indexPath]) {
        [cell setBackgroundColor:[UIColor greenColor]];
        [cell.nameLabel setTextColor:[UIColor redColor]];
    } else {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
        [cell.nameLabel setTextColor:[UIColor blackColor]];
    }
    
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float w = (self.view.frame.size.width - 60)/3;
    float h = w;
    return (CGSize){w,h};
}

//这个是两行cell之间的间距（上下行cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectIndexPath = indexPath;
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor greenColor]];
    [cell.nameLabel setTextColor:[UIColor redColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.DeselectIndexpath = indexPath;
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) { // 如果重用之后拿不到cell,就直接返回
        return;
    }
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    [cell.nameLabel setTextColor:[UIColor blackColor]];
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *tCell = (CollectionViewCell *)cell;
    if (self.DeselectIndexpath && [self.DeselectIndexpath isEqual:indexPath]) {
        
        [tCell setBackgroundColor:[UIColor lightGrayColor]];
        [tCell.nameLabel setTextColor:[UIColor blackColor]];
    }
    
    if ([self.selectIndexPath isEqual:indexPath]) {
        [tCell setBackgroundColor:[UIColor greenColor]];
        [tCell.nameLabel setTextColor:[UIColor redColor]];
    }
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArrayM {
    if (!_dataArrayM) {
        _dataArrayM = [NSMutableArray array];
    }
    return _dataArrayM;
}

@end
