//
//  QTimeLine.h
//  testprocess
//
//  Created by Chin on 17/6/1.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol QTimeLineDelegate <NSObject>

- (void) timelineMoveToDate:(NSDate*)date;

- (void) timelineDisplayUpdate:(NSDate*)from to:(NSDate*)to customview:(UIView*)customview;

@end




@interface QTimeLine : UIView

@property(nonatomic, weak) id<QTimeLineDelegate> delegate;

- (void) moveToDate:(NSDate*)date;

@end
