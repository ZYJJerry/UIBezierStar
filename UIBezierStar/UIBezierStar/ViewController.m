//
//  ViewController.m
//  UIBezierStar
//
//  Created by Jerry on 2016/10/17.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "ViewController.h"
#define wide 10
#define index 5
#define angel72 M_PI_2*72/90.f
#define angel54 M_PI_2*54/90.f
#define angel16 M_PI_2*16/90.f
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ViewController ()
{
    double add;
}
//创建全局属性
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,strong) UIBezierPath * bezier;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initShape];
    [self createBezier];
}

- (void)initShape{
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 450, 550);
    self.shapeLayer.position = self.view.center;
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 2.0f;
    self.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    //设置stroke起始点
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    add = 0.1;
}

- (void)createBezier{
    //创建出圆形贝塞尔曲线
    //类方法实例化
   self.bezier = [UIBezierPath bezierPath];
    //调整笔的粗细
    self.bezier.lineWidth = 2.f;
    for (int i = 1; i < 6; i++) {
        [self drawPentagon:self.bezier WithPosition:ScreenWidth/6 * i];
    }
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = self.bezier.CGPath;
    
    //添加并显示
    [self.view.layer addSublayer:self.shapeLayer];
}

- (void)drawPentagon:(UIBezierPath *)bezier WithPosition:(CGFloat)p {
    //确定最上面的中心点
    CGPoint centPoint = CGPointMake(p, 80);
    [bezier moveToPoint:centPoint];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72), 80+wide*sin(angel72))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide, 80+wide*sin(angel72))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide+wide*sin(angel54), 80+wide*sin(angel72)+wide*cos(angel54))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide+wide*sin(angel54)-wide*sin(angel16), 80+wide*sin(angel72)+wide*cos(angel54)+wide*cos(angel16))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide+wide*sin(angel54)-wide*sin(angel16)+wide*sin(angel54), 80+wide*sin(angel72)+wide*cos(angel16))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide+wide*sin(angel54)-wide*sin(angel16)+wide*sin(angel54)*2, 80+wide*sin(angel72)+wide*cos(angel54)+wide*cos(angel16))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)-wide+wide*sin(angel54)-wide*sin(angel16)+wide*sin(angel54)*2-wide*sin(angel16), 80+wide*sin(angel72)+wide*cos(angel54))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)+wide+2*wide*cos(angel72), 80+wide*sin(angel72))];
    [bezier addLineToPoint:CGPointMake(centPoint.x-wide*cos(angel72)+2*wide*cos(angel72), 80+wide*sin(angel72))];
    //封闭，将最后的一个点和第一开始的点(这个demo中的centPoint)相连，构成一个封闭空间
    [bezier closePath];
}

- (void)circleAnimationTypeOne
{
#if 1
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1) {
        self.shapeLayer.strokeStart += add;
    }else if(self.shapeLayer.strokeStart == 0){
        self.shapeLayer.strokeEnd += add;
    }
    
    if (self.shapeLayer.strokeEnd == 0) {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd) {
        self.shapeLayer.strokeEnd = 0;
    }
#else
    if (self.shapeLayer.strokeEnd < 1) {
        self.shapeLayer.strokeEnd += add;
    }
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeEnd < 2) {
        [_timer invalidate];
        self.shapeLayer.fillColor = [UIColor redColor].CGColor;
    }
#endif
}

- (void)circleAnimationTypeTwo
{
    CGFloat valueOne = arc4random() % 100 / 100.0f;
    CGFloat valueTwo = arc4random() % 100 / 100.0f;
    
    self.shapeLayer.strokeStart = valueOne < valueTwo ? valueOne : valueTwo;
    self.shapeLayer.strokeEnd = valueTwo > valueOne ? valueTwo : valueOne;
}


- (void)timeGo{
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
}

- (IBAction)timerGoGo:(id)sender {
    [self timeGo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
