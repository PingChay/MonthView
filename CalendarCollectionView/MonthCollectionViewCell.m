//
//  MonthCollectionViewCell.m
//  MaxSolution
//
//  Created by PingChay 's MacMiNi on 2/11/15.
//  Copyright (c) 2015 Saran Nonkamjan. All rights reserved.
//

#import "MonthCollectionViewCell.h"

@implementation MonthCollectionViewCell

+ (UINib *)nib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return [UINib nibWithNibName:@"MonthCollectionViewCell" bundle:[NSBundle mainBundle]];
    else
        return [UINib nibWithNibName:@"MonthCollectionViewCell" bundle:[NSBundle mainBundle]];
}

- (NSString *)reuseIdentifier
{
    return [MonthCollectionViewCell identifier];
}

+ (NSString *)identifier
{
    return @"MonthCollectionViewCellIdenifier";
}

- (void)awakeFromNib {
    // Initialization code
    
    [self.optionLabel.layer setCornerRadius:7];
}

@end
