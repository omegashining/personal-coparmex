//
//  XYZEventCell.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/27/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZEventCell.h"

@implementation XYZEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.1];
    self.backgroundColor = [UIColor clearColor];
}

@end
