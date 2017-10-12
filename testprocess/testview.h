//
//  testview.h
//  testprocess
//
//  Created by Chin on 17/5/31.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface testview : UIScrollView
{
    CAShapeLayer *layer;
}

- (void)strokeStart:(CGFloat)value;
- (void)strokeEnd:(CGFloat)value;

@end
