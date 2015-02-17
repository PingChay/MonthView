//
//  MonthView.m
//  MaxSolution
//
//  Created by PingChay 's MacMiNi on 2/11/15.
//  Copyright (c) 2015 Saran Nonkamjan. All rights reserved.
//

#import "MonthView.h"

#import "MonthCollectionViewCell.h"

@interface MonthView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UIView *view;

@property (strong, nonatomic) IBOutlet UICollectionView *calendarCollectionView;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *previusButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) IBOutlet UILabel *sundayLabel;
@property (strong, nonatomic) IBOutlet UILabel *mondayLabel;
@property (strong, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *fridayLabel;
@property (strong, nonatomic) IBOutlet UILabel *saturdayLabel;

@property int day;
@property int month;
@property int year;

@property BOOL isRangeView;
@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;

@property (nonatomic, strong) NSDate *startDateInMonth;
@property int numberWeeksInMonth;

- (IBAction)previousSelect:(id)sender;
- (IBAction)nextSelect:(id)sender;

@end

@implementation MonthView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    [[NSBundle mainBundle] loadNibNamed:@"MonthView" owner:self options:nil];
    
    [self.view setFrame:self.bounds];
    [self.view setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    
    [self addSubview:self.view];
    
    [self.calendarCollectionView registerNib:[MonthCollectionViewCell nib] forCellWithReuseIdentifier:[MonthCollectionViewCell identifier]];
    
    [self showMonthWithDate:[NSDate date]];
    
//    [self.sundayLabel setText:[Langauge localizedStringWithKey:@"Sun"]];
//    [self.mondayLabel setText:[Langauge localizedStringWithKey:@"Mon"]];
//    [self.tuesdayLabel setText:[Langauge localizedStringWithKey:@"Tue"]];
//    [self.wednesdayLabel setText:[Langauge localizedStringWithKey:@"Wed"]];
//    [self.thursdayLabel setText:[Langauge localizedStringWithKey:@"Thu"]];
//    [self.fridayLabel setText:[Langauge localizedStringWithKey:@"Fri"]];
//    [self.saturdayLabel setText:[Langauge localizedStringWithKey:@"Sat"]];
}

- (void)showMonthWithDate:(NSDate *)date
{
    self.isRangeView = NO;
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calender setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    self.day = (int)com.day;
    self.month = (int)com.month;
    self.year = (int)com.year;
    
    [self updateCurrentCalendar];
}

- (void)showMonthWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    self.isRangeView = YES;
    
    self.fromDate = fromDate;
    self.toDate = toDate;
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calender setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:fromDate];
    
    self.day = (int)com.day;
    self.month = (int)com.month;
    self.year = (int)com.year;
    
    [self updateCurrentCalendar];
}

- (void)reloadInputViews
{
    [self.calendarCollectionView reloadData];
}

- (void)updateCurrentCalendar
{
    // Current Month Date Calender day 1
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calender setFirstWeekday:1];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd/MM/yyyy"];
    [dateFormater setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormater setCalendar:calender];
    
    NSString *dateStr = [NSString stringWithFormat:@"01/%.2d/%.4d",self.month, self.year];
    NSDate *curr = [dateFormater dateFromString:dateStr];
    
    /// find weekday in first month (day 1)
    NSDateComponents *com = [calender components:NSCalendarUnitWeekday fromDate:curr];
    int weekday = (int)com.weekday;
    
    /// find number of weeks in month
    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:curr];
    self.numberWeeksInMonth = (int)weekRange.length;
    
    // start date in calendar
    self.startDateInMonth = [curr dateByAddingTimeInterval:-60*60*24*(weekday-1)];
    
    /// Set Date String Month Year
    NSDateFormatter *dateFormater1 = [[NSDateFormatter alloc] init];
    [dateFormater1 setDateFormat:@"MMMM yyyy"];
    [dateFormater1 setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormater1 setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [dateFormater1 setLocale:[NSLocale localeWithLocaleIdentifier:@"en"]];
    
    [self.dateLabel setText:[dateFormater1 stringFromDate:curr]];
    
    if (self.isRangeView)
    {
        NSDateComponents *fromCom = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self.fromDate];
        NSDateComponents *toCom = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:self.toDate];
        if (self.month <= fromCom.month && self.year <= fromCom.year)
            [self.previusButton setHidden:YES];
        else
            [self.previusButton setHidden:NO];
        
        if (self.month >= toCom.month && self.year >= toCom.year)
            [self.nextButton setHidden:YES];
        else
            [self.nextButton setHidden:NO];
    }
    else
    {
        [self.previusButton setHidden:NO];
        [self.nextButton setHidden:NO];
    }
    
    /// Reload Collection
    [self.calendarCollectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(monthView:changeMonth:year:)])
        [self.delegate monthView:self changeMonth:self.month year:self.year];
}

#pragma mark - UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MonthCollectionViewCell identifier] forIndexPath:indexPath];
    
    NSDate *cellDate = [self.startDateInMonth dateByAddingTimeInterval:60*60*24*indexPath.row];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calender setTimeZone:[NSTimeZone systemTimeZone]];
    [calender setFirstWeekday:1];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:cellDate];
    
    // Current date
    NSDateComponents *currentCom = [calender components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    if (com.day == currentCom.day &&
        com.month == currentCom.month &&
        com.year == currentCom.year)
    {
        [cell setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [cell.calendarDetailLabel setTextColor:[UIColor whiteColor]];
        [cell.calendarNumberLabel setTextColor:[UIColor whiteColor]];
    }
    else
    {
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.calendarDetailLabel setTextColor:[UIColor colorWithRed:231.0f/255.0f green:56.0f/255.00f blue:81.0f/255.0f alpha:1.0f]];
        [cell.calendarNumberLabel setTextColor:[UIColor colorWithRed:75.0f/255.0f green:77.0f/255.00f blue:82.0f/255.0f alpha:1.0f]];
    }
    
    if (self.isRangeView == YES)
    {
        if (([self.fromDate compare:cellDate] == NSOrderedAscending || [self.fromDate compare:cellDate] == NSOrderedSame) &&
            ([self.toDate compare:cellDate] == NSOrderedDescending || [self.toDate compare:cellDate] == NSOrderedSame))
        {
//            if (cell.backgroundColor == [UIColor clearColor])
//                [cell setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.100]];
        }
        else
        {
            if (cell.backgroundColor == [UIColor clearColor])
                [cell setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.100]];
        }
    }
    
    // Check month is Current
    if (com.month != self.month)
    {
//        [cell.calendarNumberLabel setTextColor:[UIColor darkGrayColor]];
//        [cell setBackgroundColor:[UIColor grayColor]];
        
        [cell.calendarNumberLabel setText:@""];
        [cell.calendarDetailLabel setText:@""];
        [cell.optionLabel setHidden:YES];
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    else
    {
//        [cell.calendarNumberLabel setTextColor:[UIColor whiteColor]];
//        if (com.weekday == 1)
//        {
//            [cell setBackgroundColor:[UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.500]];
//        }
//        else if (com.weekday == 7)
//        {
//            [cell setBackgroundColor:[UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.500]];
//        }
//        else
//        {
//            [cell setBackgroundColor:[UIColor blackColor]];
//        }
        
        [cell.calendarNumberLabel setText:[NSString stringWithFormat:@"%d",(int)com.day]];
        
        if ([self.delegate respondsToSelector:@selector(monthView:detailWithDate:)])
            [cell.calendarDetailLabel setText:[self.delegate monthView:self detailWithDate:cellDate]];
        else
            [cell.calendarDetailLabel setText:@""];
        
        if ([self.delegate respondsToSelector:@selector(monthView:showOptionWithDate:height:)] &&
            [self.delegate respondsToSelector:@selector(monthView:optionWithDate:height:)])
        {
            if ([self.delegate monthView:self showOptionWithDate:cellDate height:cell.frame.size.height] == YES)
            {
                [cell.optionLabel setHidden:NO];
                [cell.optionLabel setText:[self.delegate monthView:self optionWithDate:cellDate height:cell.frame.size.height]];
            }
            else
            {
                [cell.optionLabel setHidden:YES];
            }
        }
        else
            [cell.optionLabel setHidden:YES];
    }
    
    // setting day cell
    [cell setCalendarDate:cellDate];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MonthCollectionViewCell *cell = (MonthCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calender setTimeZone:[NSTimeZone systemTimeZone]];
    [calender setFirstWeekday:1];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:cell.calendarDate];
    
    if (com.year < self.year)
    {
        [self previousSelect:nil];
    }
    else if (com.year > self.year)
    {
        [self nextSelect:nil];
    }
    else if (com.month < self.month)
    {
        [self previousSelect:nil];
    }
    else if (com.month > self.month)
    {
        [self nextSelect:nil];
    }
    else
    {
        NSLog(@"%@",cell.calendarDate);
        
        if (self.isRangeView == YES)
        {
            if (([self.fromDate compare:cell.calendarDate] == NSOrderedAscending || [self.fromDate compare:cell.calendarDate] == NSOrderedSame) &&
                ([self.toDate compare:cell.calendarDate] == NSOrderedDescending || [self.toDate compare:cell.calendarDate] == NSOrderedSame))
            {
                // continues.
            }
            else
            {
                [collectionView deselectItemAtIndexPath:indexPath animated:YES];
                return;
            }
        }
        
        if ([self.delegate respondsToSelector:@selector(monthView:selectDate:)])
            [self.delegate monthView:self selectDate:cell.calendarDate];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberWeeksInMonth * 7;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return CGSizeMake((int)((collectionView.frame.size.width - 6)/7), (int)((collectionView.frame.size.height - self.numberWeeksInMonth + 1)/self.numberWeeksInMonth));
    return CGSizeMake(collectionView.frame.size.width/7, 43);
}

#pragma mark - Action

- (IBAction)previousSelect:(id)sender
{
    if ([self.previusButton isHidden])
        return;
    
    if (self.month == 1)
    {
        self.month = 12;
        self.year -= 1;
    }
    else
    {
        self.month -= 1;
    }

    [self updateCurrentCalendar];
}

- (IBAction)nextSelect:(id)sender
{
    if ([self.nextButton isHidden])
        return;

    if (self.month == 12)
    {
        self.month = 1;
        self.year += 1;
    }
    else
    {
        self.month += 1;
    }

    [self updateCurrentCalendar];
}

@end
