//
//  MPWaterfallLayout.h
//  tableView
//
//  Created by wuw on 16/6/1.
//  Copyright © 2016年 Kingnet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPWaterfallLayout;
@protocol WaterflowLayoutDelegate <NSObject>

- (CGFloat)flowLayout:(MPWaterfallLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface MPWaterfallLayout : UICollectionViewFlowLayout
/*cell的列间距*/
@property (nonatomic,assign) CGFloat columnMargin;
/*cell的行间距*/
@property (nonatomic,assign) CGFloat rowMargin;
/*cell的top,right,bottom,left间距*/
@property (nonatomic,assign) UIEdgeInsets insets;
/*显示多少列*/
@property (nonatomic,assign) NSInteger count;
@property (weak, nonatomic) id <WaterflowLayoutDelegate>delegate;
@end
