//
//  MPWaterfallLayout.m
//  tableView
//
//  Created by wuw on 16/6/1.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import "MPWaterfallLayout.h"
@interface MPWaterfallLayout()
/**
 *  key:cell对应的列，value:cell底部位置的Y
 */
@property (nonatomic, strong) NSMutableDictionary *cellInfo;
@property (nonatomic, strong) NSArray *layoutAttributesArray;
@end

@implementation MPWaterfallLayout
#pragma mark - Life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnMargin = 15;
        self.rowMargin = 15;
        self.insets = UIEdgeInsetsMake(15, 15, 15, 15);
        self.cellInfo = [NSMutableDictionary dictionary];
        for (int i = 0; i < self.count; i++) {
            [self.cellInfo setObject:@(self.insets.top) forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return self;
}
- (void)prepareLayout{
    [super prepareLayout];
    for (int i=0; i<self.count; i++) {
        NSString *index = [NSString stringWithFormat:@"%d",i];
        self.cellInfo[index] = @(self.insets.top);
    }
    [self computeAttributes];
}
- (void)computeAttributes{
    NSMutableArray *result = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger i; i < sectionCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        [result addObject:attributes];
    }
    self.layoutAttributesArray = [result copy];
}
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttributesArray;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    __block NSString *minYIndexForColumn = @"0";
    __block float minY = [self.cellInfo[@"0"] floatValue];
    [self.cellInfo enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj floatValue] < minY) {
            minY = [obj floatValue];
            minYIndexForColumn = key;
        }
    }];
    CGFloat width = (self.collectionView.frame.size.width - self.insets.left - self.insets.right - self.columnMargin * (self.count - 1)) / self.count;
    CGFloat height = [self getRandomHeightBetweenA:100 andB:160];
    CGFloat y = self.insets.bottom + [self.cellInfo[minYIndexForColumn] floatValue];
    CGFloat x = self.insets.left + (width + self.columnMargin) * [minYIndexForColumn integerValue];
    attributes.frame = CGRectMake(x, y, width, height);
    self.cellInfo[minYIndexForColumn] = @(height + y);
    return attributes;
}

#pragma mark - Tools
- (float)getRandomHeightBetweenA:(NSInteger)a andB:(NSInteger)b{
    return (float)(b - a + (arc4random() % (a + 1)));
}
@end
