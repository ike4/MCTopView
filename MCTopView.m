//
//  MCTopView.m
//  Tools
//
//  Created by ike on 2017/1/20.
//  Copyright © 2017年 ike. All rights reserved.
//

#import "MCTopView.h"
#import "NSString+Extension.h"

@interface MCTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *mcDataArray;
    __weak IBOutlet UICollectionView *mcCollection;
    __weak IBOutlet NSLayoutConstraint *mcCollection_W;
    NSString *jsonKey;
    UIColor *selendColor;
    NSInteger selend;
    MCtopViewCellStyle CellStyle;
    BOOL isPage;
    CGFloat cellSizeSpacing;
    UIColor *defultColor;
    
}
@end

@implementation MCTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    mcCollection.delegate = self;
    mcCollection.dataSource = self;
    [mcCollection registerNib:[UINib nibWithNibName:@"MCTopViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellID"];
}
+(MCTopView *)mcDefaultMCPickViewController:(UIViewController *)Controller setFrame:(CGRect)frame{
    MCTopView *PickViewAlert = [[[NSBundle mainBundle]loadNibNamed:@"MCTopView" owner:nil options:nil]objectAtIndex:0];
    PickViewAlert.frame = frame;
    [Controller.view addSubview:PickViewAlert];
    return PickViewAlert;
}
//每个区有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return mcDataArray.count;
}
#pragma mark CollectionSelfCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MCTopViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (jsonKey != nil) {
        cell.title.text = mcDataArray[indexPath.row][jsonKey];
    }else{
       cell.title.text = mcDataArray[indexPath.row];
    }
    switch (CellStyle) {
        case MCTopViewStateNormal:{
            [cell.rightLine removeFromSuperview];
            [cell.btomLine removeFromSuperview];
            if (selend == indexPath.row) {
                cell.title.textColor = selendColor;
            }else{
                if (defultColor != nil) {
                    cell.title.textColor = defultColor;
                }else{
                   cell.title.textColor = [UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8];
                }
            }
        }
            break;
        case MCTopViewStateLine:{
            cell.btomLine.backgroundColor = selendColor;
            if (indexPath.row == mcDataArray.count - 1){
                [cell.rightLine removeFromSuperview];
            }
            if (selend == indexPath.row) {
                cell.btomLine.hidden = NO;
                cell.btomLine.backgroundColor = selendColor;
                cell.title.textColor = selendColor;
            }else{
                if (defultColor != nil) {
                    cell.title.textColor = defultColor;
                }else{
                    cell.title.textColor = [UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8];
                }
                cell.btomLine.hidden = YES;
            }
        }
            break;
        case MCTopViewStateBgViews:{
            [cell.rightLine removeFromSuperview];
            [cell.btomLine removeFromSuperview];
            cell.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:0.8];
            cell.layer.cornerRadius = 3;
            cell.layer.masksToBounds = YES;
            if (selend == indexPath.row) {
                cell.backgroundColor = selendColor;
                cell.title.textColor = [UIColor whiteColor];
            }else{
                if (defultColor != nil) {
                    cell.title.textColor = defultColor;
                }else{
                   cell.title.textColor = [UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8];
                }
            }
        }
            break;
        case MCTopViewStateBorder:{
            [cell.rightLine removeFromSuperview];
            [cell.btomLine removeFromSuperview];
            cell.layer.masksToBounds = YES;
            cell.layer.cornerRadius = 3.0;
            cell.layer.borderWidth = 1.0;
            if(selend == indexPath.row){
                cell.layer.borderColor = [selendColor CGColor];
                cell.title.textColor = selendColor;
            }else{
                if (defultColor != nil) {
                    cell.layer.borderColor = [defultColor CGColor];
                    cell.title.textColor = defultColor;
                }else{
                    cell.layer.borderColor = [[UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8] CGColor];
                    cell.title.textColor = [UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8];
                }
            }
            
        }
            break;
        case MCTopViewStateDividing:{
            [cell.btomLine removeFromSuperview];
            if (indexPath.row == mcDataArray.count -1) {
                [cell.rightLine setHidden:YES];
            }else{
                cell.rightLine.hidden = NO;
            }
            if (selend == indexPath.row) {
                cell.title.textColor = selendColor;
            }else{
                if (defultColor != nil) {
                    cell.title.textColor = defultColor;
                }else{
                    cell.title.textColor = [UIColor colorWithRed:91.0/255.0 green:91.0/255.0 blue:91.0/255.0 alpha:0.8];
                }
            }
        }
            break;
        default:
            break;
    }
    return cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (jsonKey != nil){
        CGSize size = [mcDataArray[indexPath.row][jsonKey] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width,20)];
        return CGSizeMake(size.width + 10, self.frame.size.height);
    }else{
        CGSize size = [mcDataArray[indexPath.row] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width, 20)];
        return CGSizeMake(size.width + 10, self.frame.size.height);
    }
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,cellSizeSpacing,0,cellSizeSpacing);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return cellSizeSpacing;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    selend = indexPath.row;
    [mcCollection reloadData];
    self.mcData(indexPath.row,mcDataArray[indexPath.row]);
}
-(void)mcDefaultSetColor:(UIColor *)color{
    defultColor = color;
}
-(void)mcDataArray:(NSArray *)dataArray JsonKey:(NSString *)key SelendColor:(UIColor *)color isPage:(BOOL)isOk cellSizeSpacing:(CGFloat)spacing CellStyle:(MCtopViewCellStyle)style ReturnData:(MCTopSelendData)block{
    mcDataArray = [NSArray arrayWithArray:dataArray];
    jsonKey = key;
    selendColor = color;
    self.mcData = block;
    CellStyle = style;
    isPage = isOk;
    cellSizeSpacing = spacing;
    CGFloat mcCollection_width = 0;
    mcCollection_width += dataArray.count *spacing;
    for (int i = 0; i < dataArray.count; i++){
        if (key != nil) {
            mcCollection_width += [dataArray[i][key] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width, 20)].width;
        }else{
            mcCollection_width += [dataArray[i] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width, 20)].width;
        }
    }
    if (isOk == NO){
        if (mcCollection_width > self.window.bounds.size.width){
            mcCollection_width += dataArray.count * 10;
            mcCollection_W.constant = mcCollection_width;
        }else{
            if (style == MCTopViewStateBgViews) {
                mcCollection_width += dataArray.count * 5;
            }else if (style == MCTopViewStateDividing){
                mcCollection_width += dataArray.count * 10;
            }
            mcCollection_W.constant = mcCollection_width;
        }
    }else{
        mcCollection_W.constant = self.bounds.size.width;
    }
    [mcCollection reloadData];
}
-(void)mcDataArray:(NSArray *)dataArray JsonKey:(NSString *)key SelendColor:(UIColor *)color isPage:(BOOL)isOk scrollEnabled:(BOOL)scroll cellSizeSpacing:(CGFloat)spacing CellStyle:(MCtopViewCellStyle)style ReturnData:(MCTopSelendData)block{
    mcDataArray = [NSArray arrayWithArray:dataArray];
    jsonKey = key;
    selendColor = color;
    self.mcData = block;
    CellStyle = style;
    isPage = isOk;
    cellSizeSpacing = spacing;
    CGFloat mcCollection_width = 0;
    mcCollection_width += dataArray.count *spacing;
    mcCollection.scrollEnabled = scroll;
    for (int i = 0; i < dataArray.count; i++){
        if (key != nil) {
            mcCollection_width += [dataArray[i][key] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width, 20)].width;
        }else{
            mcCollection_width += [dataArray[i] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(self.window.bounds.size.width, 20)].width;
        }
    }
    if (isOk == NO){
        if (mcCollection_width > self.window.bounds.size.width) {
            mcCollection_width += dataArray.count * 10;
            mcCollection_W.constant = mcCollection_width;
        }else{
            if (style == MCTopViewStateBgViews) {
               mcCollection_width += dataArray.count * 5;
            }
            mcCollection_W.constant = mcCollection_width;
        }
    }else{
        mcCollection_W.constant = self.bounds.size.width;
    }
    [mcCollection reloadData];
}
@end

@interface MCTopViewCell (){
    __weak IBOutlet UIView *line;
    __weak IBOutlet UILabel *top;
    __weak IBOutlet NSLayoutConstraint *line_H;
}

@end

@implementation MCTopViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
}
@end
