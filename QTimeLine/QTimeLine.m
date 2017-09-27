//
//  QTimeLine.m
//  testprocess
//
//  Created by Chin on 17/6/1.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "QTimeLine.h"
#import "QTimeLineDate.h"
#import "QTimeLineContent.h"
#import "QTimeLineMask.h"



@interface QTimeLine()

@property(nonatomic) QTimeLineContent * contentView;

@property(nonatomic) QTimeLineMask * maskView;

@property(nonatomic) UIView * customView;


@end


@implementation QTimeLine

- (void) drawRect:(CGRect)rect {
    
}


- (void) layoutSubviews {
    _contentView.frame = self.bounds;
    
    _maskView.frame = self.bounds;
    
    _customView.frame = CGRectMake(0, self.height / 2, self.width, self.height / 2);
}


#pragma mark - func

- (void) dealCallback {
    __weak typeof(self) weakself = self;
    
    _contentView.displayUpdateBlock =
    ^(NSDate * from, NSDate * to) {
        if ([weakself.delegate respondsToSelector:@selector(timelineDisplayUpdate:to:customview:)]) {
            [weakself.delegate timelineDisplayUpdate:from to:to customview:weakself.customView];
        }
    };
    
    _contentView.dateUpdateBlock =
    ^(NSDate * date) {
        if ([weakself.delegate respondsToSelector:@selector(timelineMoveToDate:)]) {
            [weakself.delegate timelineMoveToDate:date];
        }
    };
}

- (void) moveToDate:(NSDate *)date {
    [_contentView moveToDate:date];
}

#pragma mark - init

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype) init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void) commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    _contentView = [[QTimeLineContent alloc]init];
    [self addSubview:_contentView];
    
    [self dealCallback];
    
    _maskView = [[QTimeLineMask alloc]init];
    [self addSubview:_maskView];

    _customView = [[UIView alloc]init];
    _customView.backgroundColor = [UIColor darkGrayColor];
    _customView.userInteractionEnabled = NO;
    [self addSubview:_customView];
    
    [self bringSubviewToFront:_maskView];
}


@end
