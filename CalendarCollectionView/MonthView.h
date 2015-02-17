//
//  MonthView.h
//  MaxSolution
//
//  Created by PingChay 's MacMiNi on 2/11/15.
//  Copyright (c) 2015 Saran Nonkamjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthView;

@protocol MonthViewDelegate <NSObject>

@optional
- (void)monthView:(MonthView *)monthView changeMonth:(int)month year:(int)year;
- (void)monthView:(MonthView *)monthView selectDate:(NSDate *)selectDate;
- (NSString *)monthView:(MonthView *)monthView detailWithDate:(NSDate *)date;
- (BOOL)monthView:(MonthView *)monthView showOptionWithDate:(NSDate *)date height:(float)height;
- (NSString *)monthView:(MonthView *)monthView optionWithDate:(NSDate *)date height:(float)height;

@end

@interface MonthView : UIView

@property (nonatomic, assign) id <MonthViewDelegate> delegate;

- (void)showMonthWithDate:(NSDate *)date;
- (void)showMonthWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end


