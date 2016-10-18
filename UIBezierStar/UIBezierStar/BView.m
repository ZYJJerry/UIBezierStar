//
//  BView.m
//  view
//
//  Created by Jerry on 16/10/12.
//  Copyright © 2016年 周玉举. All rights reserved.
//

#import "BView.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define wide 10
#define index 5
#define angel72 M_PI_2*72/90.f
#define angel54 M_PI_2*54/90.f
#define angel16 M_PI_2*16/90.f
@implementation BView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createBezier];
    }
    return self;
}

- (void)createBezier{
//    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //类方法实例化
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    //调整笔的粗细
    bezier.lineWidth = 2.f;
    //设置颜色
    [[UIColor redColor] set];
    for (int i=1; i<6; i++) {
      [self drawPentagon:bezier WithPosition:ScreenWidth/6 * i];
    }
    
 
    //动笔画，这个方法调用就是让程序执行划线的设定
    [bezier stroke];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/6*(index+0.5), 64, ScreenWidth, 200)];
    view.backgroundColor = [UIColor whiteColor];
    [self addSubview:view];
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
    [[UIColor redColor] setFill];
    [bezier fill];
}


@end
