//
//  MonthCollectionViewCell.h
//  MaxSolution
//
//  Created by PingChay 's MacMiNi on 2/11/15.
//  Copyright (c) 2015 Saran Nonkamjan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *calendarNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *calendarDetailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *selectImageView;
@property (strong, nonatomic) IBOutlet UILabel *optionLabel;

@property (strong, nonatomic) NSDate *calendarDate;

+ (UINib *)nib;
+ (NSString *)identifier;

@end
