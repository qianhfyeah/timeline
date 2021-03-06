//
//  testview.m
//  testprocess
//
//  Created by Chin on 17/5/31.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "testview.h"

@implementation testview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        layer = [CAShapeLayer layer];
        layer.frame = self.bounds;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.height / 2.0f,
                                                                               self.frame.size.height / 2.0f)
                                                            radius:self.frame.size.height / 2.f
                                                        startAngle:0
                                                          endAngle:M_PI * 2
                                                         clockwise:YES];
        
        layer.strokeColor   = [UIColor greenColor].CGColor;   // 边缘线的颜色
        layer.fillColor     = [UIColor clearColor].CGColor;   // 闭环填充的颜色
        layer.lineCap       = kCALineCapSquare;               // 边缘线的类型
        layer.path          = path.CGPath;                    // 从贝塞尔曲线获取到形状
        layer.lineWidth     = 1.0f;                           // 线条宽度
        layer.strokeStart   = 0.0f;
        layer.strokeEnd     = 0.0f;
        
        [self.layer addSublayer:layer];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        NSLog(@"%@", data);
        
    }
    return self;
}

- (void)strokeStart:(CGFloat)value
{
    layer.speed = 1;
    layer.strokeStart = value;
}

- (void)strokeEnd:(CGFloat)value
{
    layer.speed = 1;
    layer.strokeEnd = value;
}

@end
