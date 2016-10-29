

#import "ViewController.h"
#import "YCCircleView.h"
@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建扇形视图
    YCCircleView *circleView = [[YCCircleView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    
    // -------------- 下面的数据源传入的数据数组个数最好保持一致,  ---- 可设置扇形个数
    // 扇形区域的数据：保证数组中值和为1
    circleView.dataSource = @[@0.4,@0.3,@0.1,@0.1,@0.05,@0.05];
    // 每个扇形区域的背景颜色
    circleView.colorSource = @[[UIColor redColor],[UIColor magentaColor],[UIColor blueColor],[UIColor greenColor],[UIColor cyanColor],[UIColor orangeColor]];
    // 每个扇形区域的描述文字
    circleView.titleSource = @[@"辣",@"甜",@"鲜",@"酸",@"咸",@"苦"];
    
    [self.view addSubview:circleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
