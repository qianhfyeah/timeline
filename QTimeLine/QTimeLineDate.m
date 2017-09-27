//
//  QTimeLineDate.m
//  testprocess
//
//  Created by Chin on 17/6/2.
//  Copyright © 2017年 Chin. All rights reserved.
//

#import "QTimeLineDate.h"
#import "QTimeLineMask.h"


#define CELL_PER_PAGE 12


@interface QTimeLineDate()

@property(nonatomic, readwrite) float unitPageWidth;

@property(nonatomic, readwrite) NSDate * middleDate;

@property(nonatomic) float timeScaling;
@property(nonatomic) NSUInteger scaling;

@end


@implementation QTimeLineDate


- (void) drawRect:(CGRect)rect {
    _unitPageWidth = rect.size.width / 3;

    [self updateRuler];
    
    [self updateScale];
}

- (void) updateRuler {
    static float uni_ruler_high = 10;
    static float uni_ruler_normal = 5;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    float uni_cell_width = _unitPageWidth / CELL_PER_PAGE;
    
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < CELL_PER_PAGE; ++j) {
            float cell_x = i * _unitPageWidth + j * uni_cell_width;
            float cell_x_half = cell_x + uni_cell_width / 2;
            
            UIRectFill(CGRectMake(cell_x_half, 0, 1, uni_ruler_normal));
            UIRectFill(CGRectMake(cell_x, 0, 1, uni_ruler_high));
        }
    }
}

- (void) updateScale {
    static float uni_ruler_high = 10;
    
    float scale_ty = uni_ruler_high;
    float scale_tw = 40.0;
    float scale_th = 12.0;
    
    float uni_cell_width = _unitPageWidth / CELL_PER_PAGE;
    
    NSDictionary * textAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                     NSForegroundColorAttributeName:[UIColor lightTextColor],
                                     NSParagraphStyleAttributeName: [NSParagraphStyle defaultParagraphStyle]};
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    float seconds_cell = 3600 / _timeScaling;
    
    static NSUInteger cell_half = CELL_PER_PAGE * 3 / 2;
    
    for (int n = 0; n < cell_half; ++n) {
        float scale_tx = n * uni_cell_width - scale_tw / 2;
        
        NSDate * new_scale = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
                              [_middleDate timeIntervalSinceReferenceDate] - (cell_half-n)*seconds_cell];
        
        NSString * scale_t = [dateFormatter stringFromDate:new_scale];
        
        [scale_t drawInRect:CGRectMake(scale_tx, scale_ty, scale_tw, scale_th) withAttributes:textAttribute];
    }

    for (int p = 0; p < cell_half; ++p) {
        float scale_tx = (cell_half + p) * uni_cell_width - scale_tw / 2;
        
        NSDate * new_scale = [NSDate dateWithTimeInterval:seconds_cell * p sinceDate:_middleDate];
        
        NSString * scale_t = [dateFormatter stringFromDate:new_scale];
        
        [scale_t drawInRect:CGRectMake(scale_tx, scale_ty, scale_tw, scale_th) withAttributes:textAttribute];
    }
    
}


- (void) layoutSubviews {
    
   // [self setNeedsDisplay];
}



- (void) initMiddleDate:(NSDate *)date {
    _middleDate = date;
}

- (void) updateMiddleDate:(BOOL)positive {
    float seconds_cell = 3600 / _timeScaling;
    
    NSDate * middle_date;
    if (positive) {
        middle_date = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
                       [_middleDate timeIntervalSinceReferenceDate] + seconds_cell * 12];
    }
    else {
        middle_date = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:
                       [_middleDate timeIntervalSinceReferenceDate] - seconds_cell * 12];
    }

    _middleDate = middle_date;
    
    [self setNeedsDisplay];
}

- (void) resetRuler:(NSDate *)middleDate {
    _middleDate = middleDate;
    
    _scaling = _timeScaling = 1;
    
    [self setNeedsDisplay];
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
    [self setBackgroundColor:[UIColor darkGrayColor]];
    self.alpha = 0.8;
    
    self.userInteractionEnabled = NO;
    
    _timeScaling = 1;
    _scaling = 1;
    _middleDate = [NSDate date];
}

- (float) getTimeScaling:(NSUInteger) scaling {
    NSDictionary * dict = @{@1:@1, @2:@2, @4:@6, @8:@12, @16:@60};
    
    NSNumber * num = [dict objectForKey:[NSNumber numberWithInteger:scaling]];
    if (num) {
        return num.floatValue;
    }
    return -1.0;
}

#pragma mark - getter/setter

- (float) unitCellSeconds {
    return 3600 / _timeScaling;
}

- (float) unitCellWidth {
    return self.width / 3 / CELL_PER_PAGE;
}

- (BOOL) setRulerScale:(BOOL)zoomIn {
    
    BOOL scaleChanged = false;
    if (zoomIn) {
        float ns = [self getTimeScaling:_scaling * 2];
        if (ns > 0) {
            _timeScaling = ns;
            _scaling *= 2;
            scaleChanged = true;
        }
    }
    else {
        float ns = [self getTimeScaling:_scaling / 2];
        if (ns > 0) {
            _timeScaling = ns;
            _scaling /= 2;
            scaleChanged = true;
        }
    }
    
    if (scaleChanged) {
        [self setNeedsDisplay];
        return true;
    }
    return false;
}

@end
