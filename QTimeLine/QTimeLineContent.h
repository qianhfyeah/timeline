//
//  QTimeLineContent.h
//  testprocess
//
//  Created by Chin on 17/6/2.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QTimeLineContent : UIScrollView

// default YES
@property(nonatomic) BOOL futureLimited;

@property (nonatomic, copy) void(^dateUpdateBlock)(NSDate * date);
@property (nonatomic, copy) void(^displayUpdateBlock)(NSDate * from, NSDate * to);


- (void) moveToDate:(NSDate*)date;

@end
