//
//  ViewController.m
//  CalendarCollectionView
//
//  Created by PingChay 's MacMiNi on 9/4/14.
//  Copyright (c) 2014 Saran Nonkamjan. All rights reserved.
//

#import "ViewController.h"
#import "CalendarCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

@property int month;
@property int year;

@property (nonatomic, strong) NSDate *startDateInMonth;
@property int numberWeeksInMonth;

- (IBAction)previousSelect:(id)sender;
- (IBAction)nextSelect:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
    [calender setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    
    self.month = com.month;
    self.year = com.year;
    
    [self updateCurrentCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCurrentCalendar
{
    // Current Month Date Calender day 1
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
    [calender setFirstWeekday:1];
    
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"dd/MM/yyyy"];
    [dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormater setCalendar:calender];
    
    NSString *dateStr = [NSString stringWithFormat:@"01/%.2d/%.4d",self.month, self.year];
    NSDate *curr = [dateFormater dateFromString:dateStr];
    
    /// find weekday in first month (day 1)
    NSDateComponents *com = [calender components:NSCalendarUnitWeekday fromDate:curr];
    int weekday = com.weekday;
    
    /// find number of weeks in month
    NSRange weekRange = [calender rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:curr];
    self.numberWeeksInMonth = weekRange.length;
    
    // start date in calendar
    self.startDateInMonth = [curr dateByAddingTimeInterval:-60*60*24*(weekday-1)];
    
    /// Set Date String Month Year
    NSDateFormatter *dateFormater1 = [[NSDateFormatter alloc] init];
    [dateFormater1 setDateFormat:@"MMMM yyyy"];
    [dateFormater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormater1 setCalendar:calender];
    [dateFormater1 setLocale:[NSLocale localeWithLocaleIdentifier:@"th"]];
    
    [self.dateLabel setText:[dateFormater1 stringFromDate:curr]];
    
    /// Reload Collection
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ExampleCellID" forIndexPath:indexPath];
    
    NSDate *cellDate = [self.startDateInMonth dateByAddingTimeInterval:60*60*24*indexPath.row];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [calender setFirstWeekday:1];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:cellDate];
    
    // Check month is Current
    if (com.month != self.month)
        [cell.calendarNumberLabel setTextColor:[UIColor darkGrayColor]];
    else
        [cell.calendarNumberLabel setTextColor:[UIColor whiteColor]];
    
    // setting day cell
    [cell.calendarNumberLabel setText:[NSString stringWithFormat:@"%d",com.day]];
    [cell setCalendarDate:cellDate];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarCollectionViewCell *cell = (CalendarCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSBuddhistCalendar];
    [calender setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [calender setFirstWeekday:1];
    
    NSDateComponents *com = [calender components:(NSCalendarUnitMonth) fromDate:cell.calendarDate];
    
    if (com.month < self.month)
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
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberWeeksInMonth * 7;
}

#pragma mark - Action

- (IBAction)previousSelect:(id)sender
{
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
