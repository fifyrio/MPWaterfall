//
//  MainViewController.m
//  tableView
//
//  Created by 吴伟 on 15/10/9.
//  Copyright © 2015年 com.weizong. All rights reserved.
//

#import "MainViewController.h"
#import "MPWaterfallLayout.h"
#import "MPWaterfallCell.h"

static NSString * const kMPWaterfallCell = @"MPWaterfallCell";

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) NSArray *data;
@property (strong, nonatomic) MPWaterfallLayout * flowLayout;
@end

@implementation MainViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self setUpViews];
    self.data = @[@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"1.jpg",@"2.jpg",@"0.jpg",@"2.jpg",@"0.jpg",@"2.jpg",@"0.jpg"];
}

#pragma mark - Initialize
- (void)setUpViews{
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MPWaterfallCell" bundle:nil] forCellWithReuseIdentifier:kMPWaterfallCell];
    self.flowLayout = [[MPWaterfallLayout alloc] init];
    self.flowLayout.count = 3;
    self.collectionView.collectionViewLayout = self.flowLayout;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MPWaterfallCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMPWaterfallCell forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.data[indexPath.section]];
    return cell;
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
