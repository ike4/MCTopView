//
//  MCTopView.h
//  Tools
//
//  Created by ike on 2017/1/20.
//  Copyright © 2017年 ike. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,MCtopViewCellStyle){
    MCTopViewStateNormal    = 0,/**默认风格*/
    MCTopViewStateLine      = 1,/*下划线*/
    MCTopViewStateBgViews   = 2,/*背景色*/
    MCTopViewStateBorder    = 3,/*边框*/
    MCTopViewStateDividing  = 4/*分隔线*/
};
typedef void(^MCTopSelendData)(NSInteger mcItem,id mcData);
@interface MCTopView : UIView
@property(nonatomic,strong)MCTopSelendData mcData;
/**
 默认方式
 初始化
 frame位置
 Sorting:少量数据方式
 */
+(MCTopView *)mcDefaultMCPickViewController:(UIViewController *)Controller setFrame:(CGRect)frame;
/*
 设置默认颜色
 */
-(void)mcDefaultSetColor:(UIColor *)color;
/**
 背景
 dataArray:数据
 key:数据字典的---->Key
 color:选中的颜色
 isOk:是否分页 (数据超出屏幕处理:少量数据居中)
 block:获取操作返回数据
 style:cell 展示风格
 spacing:间距
 */
-(void)mcDataArray:(NSArray *)dataArray JsonKey:(NSString *)key SelendColor:(UIColor *)color isPage:(BOOL)isOk cellSizeSpacing:(CGFloat)spacing CellStyle:(MCtopViewCellStyle)style ReturnData:(MCTopSelendData)block;
/**
背景
 dataArray:数据
 key:数据字典的---->Key
 color:选中的颜色
 isOk:是否分页 (数据超出屏幕处理:少量数据居中)
 block:获取操作返回数据
 style:cell 展示风格
 spacing:间距
 scroll:是否滑动
 */
-(void)mcDataArray:(NSArray *)dataArray JsonKey:(NSString *)key SelendColor:(UIColor *)color isPage:(BOOL)isOk scrollEnabled:(BOOL)scroll cellSizeSpacing:(CGFloat)spacing CellStyle:(MCtopViewCellStyle)style ReturnData:(MCTopSelendData)block;
@end

@interface MCTopViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *btomLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;

@end
