//
//  HomeListView.m
//  CBCP
//
//  Created by LC on 2017/5/17.
//  Copyright © 2017年 LC. All rights reserved.
//

#import "HomeListView.h"
#import "HomeListViewModel.h"
#import "HomeCollectionViewCell.h"
#import "HomeHeaderView.h"
@interface HomeListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) HomeListViewModel *viewModel;

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation HomeListView

- (instancetype)initWithViewModel:(id<CBViewModelProtocol>)viewModel
{
    self.viewModel = (HomeListViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints
{
    WS(weakSelf)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

- (void)cb_setupViews
{
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)cb_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = ALLVIEWBACKCOLOR;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeCollectionViewCell class])]];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([UICollectionReusableView class])]];
    }
    
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.minimumLineSpacing = 10;
//        _flowLayout.headerReferenceSize = CGSizeMake(self.frame.size.width, SCREEN_WIDTH/2 + 20 + 40); //设置collectionView头视图的大小

    }
    
    return _flowLayout;
}

- (HomeListViewModel *)viewModel
{
    
    if (!_viewModel) {
        
        _viewModel = [[HomeListViewModel alloc] init];
    }
    
    return _viewModel;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.viewModel.dataArray.count);
    return self.viewModel.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HomeCollectionViewCell class])] forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor blueColor];
    cell.model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    return cell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
//    if([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([UICollectionReusableView class])] forIndexPath:indexPath];
//        if(headerView == nil)
//        {
//            headerView = [[UICollectionReusableView alloc] init];
//        }
//        headerView.backgroundColor = [UIColor grayColor];
//        
//        
//        HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc] initWithViewModel:self.viewModel];
//        [headerView addSubview:homeHeaderView];
//        [homeHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.equalTo(0);
//            make.bottom.equalTo(@10);
//        }];
//        
//        
//        return homeHeaderView;
//    }
//    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
//    {
//        UICollectionReusableView *footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
//        if(footerView == nil)
//        {
//            footerView = [[UICollectionReusableView alloc] init];
//        }
//        footerView.backgroundColor = [UIColor lightGrayColor];
//        
//        return footerView;
//    }
    
    return nil;
}


#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(SCREEN_WIDTH - 30) / 2, 60};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.cellClickSubject sendNext:nil];

    NSLog(@"%ld",indexPath.row);
}



@end
