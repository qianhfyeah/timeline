//
//  UIView+Extension.m
//  testprocess
//
//  Created by Chin on 17/6/2.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

@dynamic width;
@dynamic height;


- (float) width {
    return self.bounds.size.width;
}

- (float) height {
    return self.bounds.size.height;
}

@end
