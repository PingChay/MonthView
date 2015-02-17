# MonthView

### How to use
@property (strong, nonatomic) IBOutlet MonthView *monthView;

[self.monthView showMonthWithDate:[NSDate date]];

or

[self.monthView showMonthWithFromDate:[[NSDate date] dateByAddingTimeInterval:-10*24*60*60] toDate:[NSDate date]];

### update when interface rotation
[self.monthView reloadInputViews];

### protocal
- (void)monthView:(MonthView *)monthView changeMonth:(int)month year:(int)year;
- (void)monthView:(MonthView *)monthView selectDate:(NSDate *)selectDate;
- (NSString *)monthView:(MonthView *)monthView detailWithDate:(NSDate *)date;
- (BOOL)monthView:(MonthView *)monthView showOptionWithDate:(NSDate *)date height:(float)height;
- (NSString *)monthView:(MonthView *)monthView optionWithDate:(NSDate *)date height:(float)height;
