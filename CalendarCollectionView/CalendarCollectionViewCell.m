//
//  CalendarCollectionViewCell.m
//  CalendarCollectionView
//
//  Created by PingChay 's MacMiNi on 9/4/14.
//  Copyright (c) 2014 Saran Nonkamjan. All rights reserved.
//

#import "CalendarCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CalendarCollectionViewCell

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
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.layer setBorderWidth:0.5f];
}

@end
