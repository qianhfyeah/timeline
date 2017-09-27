//
//  QTimeLineMask.m
//  testprocess
//
//  Created by Chin on 17/6/1.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "QTimeLineMask.h"
#import "UIView+Extension.h"

@implementation QTimeLineMask


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    UIRectFill(CGRectMake(rect.size.width / 2, 1, 1, rect.size.height - 2));
}

- (instancetype) init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
}

@end
