//
//  QTimeLineDate.h
//  testprocess
//
//  Created by Chin on 17/6/2.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"



@interface QTimeLineDate : UIView

@property(nonatomic, readonly) float unitCellSeconds;
@property(nonatomic, readonly) float unitCellWidth;
@property(nonatomic, readonly) float unitPageWidth;

@property(nonatomic, readonly) NSDate * middleDate;

// positive or negative
- (BOOL) setRulerScale:(BOOL)zoomIn;

- (void) resetRuler:(NSDate*)middleDate;

- (void) initMiddleDate:(NSDate*)date;
- (void) updateMiddleDate:(BOOL)positive;

@end
