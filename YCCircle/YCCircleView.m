

#import "YCCircleView.h"

#define kCircleViewW self.bounds.size.width     // 视图本身宽度
#define kCircleViewH self.bounds.size.height    // 视图本身高度
#define kOneRadian M_PI / 180                   // 一弧度/ 180
#define kCircleX kCircleViewW * 0.5             // 圆弧中点X坐标
#define kCircleY kCircleViewH * 0.5             // 圆弧中点Y坐标
#define k360Radian 360 * kOneRadian             // 360弧度
#define kAngle(angle) ((angle) / 180 * M_PI)    // 暂时没用

#define kRanderColor [UIColor colorWithRed:arc4random() % 255/ 256.0 green:arc4random() % 255/ 256.0 blue:arc4random() % 255/ 256.0 alpha:1.0]


/** 描述控件的宽高 */
#define kLabelTextW 60
#define kLabelTextH 15

@interface YCCircleView ()
/**
 *   半径数据源
 */
@property (nonatomic, strong) NSArray *radiusSource;



@end

 @implementation YCCircleView

- (void)awakeFromNib {
    
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
         [self setup];
        
    }
    
    return self;
}
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    // 圆弧半径：根据视图的高度进行比例设置
    self.radiusSource = @[@0.4,@0.35,@0.3,@0.25,@0.2,@0.17];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    // 画第1个圆弧
    CGFloat startPoint = - kOneRadian * 90; // 开始角度
    CGFloat endPoint = 0;                   // 结束角度
    CGFloat angle = 100;                    // 画标签角度：
    for (int i = 0; i < self.dataSource.count; i ++) {
        // 设置颜色
        //        [kRanderColor set];
        
        [self.colorSource[i] setFill];
        
        if (i == 0) {
            endPoint = - kOneRadian * 90 - ([self.dataSource[0] floatValue] * k360Radian);
        }
        // 画圆弧
        CGContextAddArc(ctx, kCircleX, kCircleY, kCircleViewH * [self.radiusSource[i] floatValue] , startPoint, endPoint, 1);
        // 画直线，关闭圆弧
        CGContextAddLineToPoint(ctx, kCircleX, kCircleY);
        
        // 显示所绘制的图形
        CGContextFillPath(ctx);
        
        
        // 绘画标签
        {
            
            // 标签的中心点
            CGPoint center;
            NSLog(@"------%f",angle);
            // 角度
            CGFloat angleRadius = [self.radiusSource[i] floatValue];
            if (i == self.dataSource.count - 1) {
                angleRadius += 0.1;
            }
            //计算弧度在坐标系上的点
            center = [self calcCircleCoordinateWithCenter:CGPointMake(kCircleX, kCircleY) andWithAngle: angle   andWithRadius:kCircleViewH *angleRadius + 12] ;
            
            [self.colorSource[i] setStroke];
            CGContextMoveToPoint(ctx, kCircleX, kCircleY);
            CGContextAddLineToPoint(ctx, center.x, center.y);
            // 判断折点的方向
            if (center.x <= kCircleX) {
                CGContextAddLineToPoint(ctx, center.x - 5 , center.y );
            }else {
                CGContextAddLineToPoint(ctx, center.x + 5 , center.y );
            }
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextStrokePath(ctx);
            
            // 标签控件
            UILabel *label = [[UILabel alloc] init];
            // 根据折点的方法，去设置控件的起始位置
            if (center.x <= kCircleX) {
                label.frame = CGRectMake(center.x - kLabelTextW, center.y - kLabelTextH * 0.5, kLabelTextW, kLabelTextH);
            }   else {
                label.frame = CGRectMake(center.x  , center.y - kLabelTextH * 0.5, kLabelTextW, kLabelTextH);
            }
            
            label.backgroundColor = [UIColor clearColor];
            label.text = [NSString stringWithFormat:@"%@ %.0f%%",self.titleSource[i],[self.dataSource[i] floatValue] * 100];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = self.colorSource[i];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            // 显示所绘制的东西
            CGContextFillPath(ctx);
            angle  += [self.dataSource[i] floatValue] * 360 ; // 275
            
        }
        
        // 更新开始角度和结束角度
        startPoint = endPoint;
        if (i == self.dataSource.count - 1) {
            continue;
        }else {
            endPoint = endPoint - ([self.dataSource[i + 1] floatValue] * k360Radian);
        }
        
    }
    
    
    // 画最后圆
    CGContextAddArc(ctx,kCircleX, kCircleX, kCircleViewH * 0.1, 0, - k360Radian, 1);
    
    CGContextAddLineToPoint(ctx, kCircleX, kCircleY);
    [[UIColor whiteColor] set];
    // 显示所绘制的东西
    CGContextFillPath(ctx);
    
    
}

/**
 *  根据圆弧上的弧度值返回在坐标系上的点
 *
 *  @param center 弧度的中心
 *  @param angle  弧度的角度
 *  @param radius 弧度的半径
 *
 */
- (CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
//    NSLog(@" --centern %@",NSStringFromCGPoint(center));
//    NSLog(@"x2 --- %f , y2 --- %f",x2,y2);
    return CGPointMake(center.x+x2, center.y-y2);
}

@end
