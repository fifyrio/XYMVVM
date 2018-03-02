//
//  DemoView.m
//  Demo
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "DemoView.h"
#import "DemoViewModel.h"
#import "DemoViewCell.h"
#import <Masonry/Masonry.h>

static NSString * const kDemoViewCell = @"DemoViewCell";

static CGFloat const kDefaultCellHeight = 216;

@interface DemoView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) DemoViewModel *viewModel;

@property (nonatomic, strong) UICollectionView *mainCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation DemoView

#pragma mark - Life cycle
- (instancetype)initWithViewModel:(id<XYViewModelProtocol>)viewModel{
    self.viewModel = (DemoViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - 约束
- (void)updateConstraints{
    WS(weakSelf);
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - Protocol
- (void)xy_setupViews{
    [self addSubview:self.mainCollectionView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)xy_bindViewModel {
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DemoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDemoViewCell forIndexPath:indexPath];
    //        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenW, kDefaultCellHeight);
}

#pragma mark - Lazy load
- (UICollectionView *)mainCollectionView{
    if (_mainCollectionView == nil) {
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _mainCollectionView.backgroundColor = [UIColor clearColor];
        [_mainCollectionView registerNib:[UINib nibWithNibName:kDemoViewCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kDemoViewCell];
        _mainCollectionView.showsHorizontalScrollIndicator = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
    }
    return _mainCollectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (_flowLayout == nil) {
        _flowLayout =[[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 10;
    }
    return _flowLayout;
}

@end
