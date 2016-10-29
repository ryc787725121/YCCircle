

#import <UIKit/UIKit.h>

@interface YCCircleView : UIView


/** --------------------  警告：以下数组中的数据个数最好保持一致  -------------------- **/

/**
 *  扇形数据源数组：数组中存放着没块区域的比例大小、 数组中的值和为1就行
 */
@property (nonatomic, strong) NSArray *dataSource;

/**
 *  扇形区域背景色：数组中存放着没块区域的背景颜色
 */
@property (nonatomic, strong) NSArray *colorSource;

/**
 *  扇形区域标题描述：数组中存放着没块区域的标题
 */
@property (nonatomic, strong) NSArray *titleSource;


@end
