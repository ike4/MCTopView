

//
//  NSString+Extension.m
//  HappyTime
//
//  Created by mc on 16/10/14.
//  Copyright © 2016年 MwmMIFAN. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
