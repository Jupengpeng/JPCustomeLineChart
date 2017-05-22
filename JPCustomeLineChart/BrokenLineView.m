//
//  BrokenLineView.m
//  YunQiLaiOfCustomer
//
//  Created by 鞠鹏 on 2017/5/19.
//  Copyright © 2017年 JuPeng. All rights reserved.
//

#import "BrokenLineView.h"


#define kSideSpace 25.0f
#define kExtraSpace 10.0f
#define kTitleSize 11.0f
#define kBottomSpace 32.0f
@interface BrokenLineView (){
    //边界开始x
    CGFloat _bounceX;
    //边界开始y
    CGFloat _bounceY;
}
//折线
@property (nonatomic, strong) CAShapeLayer *lineChartLayer;
//背景
@property (nonatomic,strong) UIView *backgroundView;

//最大横坐标
@property (nonatomic,assign) CGFloat XAxisMaxValue;
//最小横坐标
@property (nonatomic,assign) CGFloat XAxisMinValue;
//最大纵坐标
@property (nonatomic,assign) CGFloat YAxisMaxValue;
//最小纵坐标
@property (nonatomic,assign) CGFloat YAxisMinValue;
//坐标横间距
@property (nonatomic,assign) CGFloat horizontalValue;
//坐标纵间距
@property (nonatomic,assign) CGFloat verticalValue;

@end


@implementation BrokenLineView
    


- (instancetype)initWithFrame:(CGRect)frame XAxisArr:(NSArray *)XAxisArr YAxisArr:(NSArray *)YAxisArr pointsArr:(NSArray *)pointsArr{
    self = [super initWithFrame:frame];
    if (self) {
        _bounceX = 28;
        _bounceY = 10.0f;
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.horizontalValue = (frame.size.width - _bounceX - kExtraSpace - kExtraSpace)/XAxisArr.count;
        self.verticalValue = (frame.size.height - _bounceY - kBottomSpace - kExtraSpace)/YAxisArr.count;
        
        self.baseColor = [UIColor orangeColor];
        
        CGFloat maxY = [YAxisArr.lastObject floatValue];
        self.YAxisMaxValue = maxY;
        
        [self createCoordinateAxisXWithContentArr:XAxisArr];
        [self createCoordinateAxisYWithContentArr:YAxisArr];
        [self createBackgroundView];
        [self processAdjustedPointsArrWithOriPointsArr:pointsArr];
    }
    return self;
}

//创建X轴
- (void)createCoordinateAxisXWithContentArr:(NSArray *)coAxisXArr{
    CGFloat originY = self.bounds.size.height - kBottomSpace + 8.0f + 0.5f;
    CGFloat originX = _bounceX;
    CGFloat titleWidth = self.horizontalValue;
    CGFloat titleHeight = 13.0f;
    
    CGFloat lineHeight = 6.0f;
    CGFloat lineWidth = 2.5f;
    CGFloat lineOriY = originY - 8.0f - 1 - lineHeight;
    for (NSInteger i = 0; i< coAxisXArr.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX + titleWidth * (i+1) - titleWidth/2.0f, originY, titleWidth, titleHeight)];
        titleLabel.textColor = self.baseColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:11.0f];
        titleLabel.text = [NSString stringWithFormat:@"%@",coAxisXArr[i]];
        [self addSubview:titleLabel];
        
        
        UILabel *lineLabel  = [[UILabel alloc] initWithFrame:CGRectMake(originX + titleWidth * (i+1) - 1, lineOriY, lineWidth, lineHeight)];
        lineLabel.backgroundColor = self.baseColor;
        [self addSubview:lineLabel];
        
    }
    
}
    
//创建Y轴
- (void)createCoordinateAxisYWithContentArr:(NSArray *)coAxisYArr{
    CGFloat originY = self.bounds.size.height - kBottomSpace ;
    CGFloat titleWidth = 23.0f;
    CGFloat titleHeight = 13.0f;
    CGFloat originX = _bounceX - titleWidth - 0.5f;;

    CGFloat lineHeight = 2.5f;
    CGFloat lineWidth = 6.0f;
    CGFloat lineOriX = _bounceX +1 ;
    for (NSInteger i = 0; i< coAxisYArr.count; i ++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY - self.verticalValue*(i + 1) - titleHeight/2.0f, titleWidth, titleHeight)];
        titleLabel.textColor = self.baseColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:11.0f];
        titleLabel.text = [NSString stringWithFormat:@"%@",coAxisYArr[i]];
        [self addSubview:titleLabel];
        
        
        UILabel *lineLabel  = [[UILabel alloc] initWithFrame:CGRectMake(lineOriX, originY - self.verticalValue*(i + 1) , lineWidth, lineHeight)];
        lineLabel.backgroundColor = self.baseColor;
        [self addSubview:lineLabel];
        
    }
    
}

//创建背景图
- (void)createBackgroundView{
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(_bounceX, _bounceY, self.bounds.size.width - _bounceX - kExtraSpace, self.bounds.size.height - _bounceY - kBottomSpace)];
    self.backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    [self insertSubview:self.backgroundView atIndex:0];
//    [self addSubview:self.backgroundView];
    
}

//处理原始点数据 ，坐标转换
- (void)processAdjustedPointsArrWithOriPointsArr:(NSArray *)oriPointsArr{
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for (NSInteger i = 0; i < oriPointsArr.count; i++) {
        NSDictionary *oriPointDict = oriPointsArr[i];
        CGFloat originY = [oriPointDict[@"y"] floatValue];
        CGFloat originX = [oriPointDict[@"x"] floatValue];
        CGFloat currentX = (i + 1) * self.horizontalValue ;

        CGFloat currentY = self.bounds.size.height - kBottomSpace - (self.frame.size.height - _bounceY - kBottomSpace - kExtraSpace) * originY/self.YAxisMaxValue ;
        [resultArr addObject:@{@"x":[NSString stringWithFormat:@"%f",currentX + _bounceX],
                              @"y":[NSString stringWithFormat:@"%f",currentY]}];
    }
    
    [self createBrokenLineWithAdjustedPointsArr:resultArr];
    
}

//画坐标点
- (void)createBrokenLineWithAdjustedPointsArr:(NSArray *)pointsArr{
    
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    path.lineWidth = 2.0f;
    [self.baseColor set];
    NSDictionary *pointDict = pointsArr.firstObject;
    CGFloat pointX = [pointDict[@"x"] floatValue];
    CGFloat pointY = [pointDict[@"y"] floatValue];
    [path moveToPoint:CGPointMake(pointX - _bounceX, pointY - kExtraSpace)];
    
    for (NSInteger i = 0; i < pointsArr.count; i ++) {
        NSDictionary *pointDict = pointsArr[i];
        CGFloat pointX = [pointDict[@"x"] floatValue];
        CGFloat pointY = [pointDict[@"y"] floatValue];
        UILabel *pointlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
        pointlabel.clipsToBounds = YES;
        pointlabel.layer.cornerRadius = 4.0f;
        pointlabel.layer.borderColor = self.baseColor.CGColor;
        pointlabel.layer.borderWidth = 1.0f;
        pointlabel.backgroundColor = [UIColor whiteColor];
        pointlabel.center = CGPointMake(pointX, pointY);
        [self addSubview:pointlabel];
        
        [path addLineToPoint:CGPointMake(pointX - _bounceX, pointY - kExtraSpace)];
    }
    
    self.lineChartLayer = [CAShapeLayer layer];
    self.lineChartLayer.path = path.CGPath;
    self.lineChartLayer.strokeColor = self.baseColor.CGColor;
    self.lineChartLayer.fillColor = [[UIColor clearColor] CGColor];
    self.lineChartLayer.lineWidth = 2.0f;
    self.lineChartLayer.lineCap = kCALineCapRound;
    self.lineChartLayer.lineJoin = kCALineJoinRound;
    [self.backgroundView.layer addSublayer:self.lineChartLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.lineChartLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    [self.baseColor set];
//    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextMoveToPoint(context, _bounceX, _bounceY);
    CGContextAddLineToPoint(context, _bounceX, rect.size.height - kBottomSpace);
    CGContextAddLineToPoint(context,rect.size.width -  kExtraSpace, rect.size.height - kBottomSpace);
    CGContextStrokePath(context);
    
    
}
    
    

@end
