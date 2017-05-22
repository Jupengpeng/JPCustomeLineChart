//
//  BrokenLineView.h
//  YunQiLaiOfCustomer
//
//  Created by 鞠鹏 on 2017/5/19.
//  Copyright © 2017年 JuPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokenLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame XAxisArr:(NSArray *)XAxisArr YAxisArr:(NSArray *)YAxisArr pointsArr:(NSArray *)pointsArr;

@property (nonatomic,strong) UIColor *baseColor;

@end
