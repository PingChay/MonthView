//
//  ViewController.m
//  CalendarCollectionView
//
//  Created by PingChay 's MacMiNi on 9/4/14.
//  Copyright (c) 2014 Saran Nonkamjan. All rights reserved.
//

#import "ViewController.h"

#import "MonthView.h"

@interface ViewController () <MonthViewDelegate>

@property (strong, nonatomic) IBOutlet MonthView *monthView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.monthView setDelegate:self];
    
//    [self.monthView showMonthWithDate:[NSDate date]];
    [self.monthView showMonthWithFromDate:[[NSDate date] dateByAddingTimeInterval:-10*24*60*60] toDate:[NSDate date]];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{    
    [self.monthView reloadInputViews];
}

#pragma mark - MonthView

- (void)monthView:(MonthView *)monthView changeMonth:(int)month year:(int)year
{
    
}

- (void)monthView:(MonthView *)monthView selectDate:(NSDate *)selectDate
{
    
}

- (NSString *)monthView:(MonthView *)monthView detailWithDate:(NSDate *)date
{
    return @"8:00\n24:00";
}

- (BOOL)monthView:(MonthView *)monthView showOptionWithDate:(NSDate *)date height:(float)height
{
    return YES;
}

- (NSString *)monthView:(MonthView *)monthView optionWithDate:(NSDate *)date height:(float)height
{
    return @"10";
}

@end
