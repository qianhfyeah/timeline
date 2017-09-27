//
//  QTimeLineContent.m
//  testprocess
//
//  Created by Chin on 17/6/2.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "QTimeLineContent.h"
#import "QTimeLineDate.h"


@interface QTimeLineContent()<UIScrollViewDelegate>

@property(nonatomic) QTimeLineDate * dateView;


@property(nonatomic) CGPoint beginDeceleratePos;

@property(nonatomic) NSDate * currentDate;

@end

@implementation QTimeLineContent


- (void) layoutSubviews {
    static BOOL initFlag = YES;
    
    if (initFlag) {
        _dateView.frame = CGRectMake(0, 0, self.width * 3, self.height);

        self.contentSize = CGSizeMake(self.width * 3, self.height);
        
        [self performCurrentOffset];

        initFlag = NO;
    }
}


#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.decelerating) return;
    
    float unit_page_width = self.width;
    
    if (scrollView.contentOffset.x >=  (scrollView.contentSize.width) - scrollView.width) {
        
        scrollView.contentOffset = CGPointMake(unit_page_width * 2 - scrollView.width, 0);
        
        [_dateView updateMiddleDate:true];
    }
    else if (scrollView.contentOffset.x <= 0) {
        
        scrollView.contentOffset = CGPointMake(unit_page_width, 0);
        
        [_dateView updateMiddleDate:false];
    }
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self updateCurrentDate:scrollView.contentOffset.x];
    
    [self checkDateWithNow];
    
    [self callback];
    
    //NSLog(@"%@ %@", _currentDate, _dateView.middleDate);
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    //_offsetX = scrollView.contentOffset.x;
}

- (void) scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"begin decelerate %lf", scrollView.contentOffset.x);
    _beginDeceleratePos = scrollView.contentOffset;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"end decelerate %lf", scrollView.contentOffset.x);
    [UIView animateWithDuration:0.1 animations:^{
        scrollView.contentOffset = _beginDeceleratePos;
    }];
}

- (void) updateCurrentDate:(float)offsetx {
    
    float timeinterval = (offsetx - self.width) * _dateView.unitCellSeconds / _dateView.unitCellWidth;
    
    NSDate * curDate = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
    [_dateView.middleDate timeIntervalSinceReferenceDate] + timeinterval];
     
    _currentDate = curDate;
}

#pragma mark - func

- (void) checkDateWithNow {
    if (!_futureLimited) return;
    
    if ([_currentDate compare:[NSDate date]] == NSOrderedDescending) {
        _currentDate = [NSDate date];
        [UIView animateWithDuration:0.1 animations:^{
            [self performCurrentOffset];
        }];
    }
}

- (void) moveToDate:(NSDate *)date {
    if ([date compare:[NSDate date]] == NSOrderedDescending) {
        date = [NSDate date];
    }
    
    float offsetX = ([date timeIntervalSince1970] - [_dateView.middleDate timeIntervalSince1970]) * _dateView.unitCellWidth / _dateView.unitCellSeconds;
    
    if (offsetX >= self.width || offsetX <= -self.width) {
        //
        NSUInteger tv = [date timeIntervalSince1970] / 3600;
        NSDate * middate = [NSDate dateWithTimeIntervalSince1970:tv * 3600];
        
        [_dateView resetRuler:middate];
        
        offsetX = ([date timeIntervalSince1970] - [_dateView.middleDate timeIntervalSince1970]) * _dateView.unitCellWidth / _dateView.unitCellSeconds;
    }
    
    _currentDate = date;
    self.contentOffset = CGPointMake(offsetX + self.width, 0);
    
    [self callback];
    
}

- (void) callback {
    if (_dateUpdateBlock) {
        _dateUpdateBlock(_currentDate);
    }
    
    if (_displayUpdateBlock) {
        NSDate * from = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
                         [_currentDate timeIntervalSinceReferenceDate] - _dateView.unitCellSeconds * 6];
        NSDate * to = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
                       [_currentDate timeIntervalSinceReferenceDate] + _dateView.unitCellSeconds * 6];
        _displayUpdateBlock(from, to);
    }
}

- (void) performCurrentOffset {
    float offsetx = ([_currentDate timeIntervalSince1970] - [_dateView.middleDate timeIntervalSince1970]) * _dateView.unitCellWidth / _dateView.unitCellSeconds;
    self.contentOffset = CGPointMake(self.width + offsetx, 0);
}

#pragma mark - UIGestureRecognizer

- (void) handleGesture:(UIPinchGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        BOOL ret = false;
        if (gestureRecognizer.velocity < 0) {
            ret = [_dateView setRulerScale:false];
        }
        else {
            ret = [_dateView setRulerScale:true];
        }
        
        if (ret) {
            [self performCurrentOffset];
        }
    }
}

#pragma mark - init

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
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.delegate = self;
    self.bounces = NO;
    
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    
    _futureLimited = true;
    
    _currentDate = [NSDate date];
    
    NSUInteger tv = [[NSDate date]timeIntervalSince1970] / 3600;
    NSDate * middate = [NSDate dateWithTimeIntervalSince1970:tv * 3600];
    
    _dateView = [[QTimeLineDate alloc]init];
    [_dateView initMiddleDate:middate];
    
    [self addSubview:_dateView];
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    [self addGestureRecognizer:pinch];
    
}



@end







