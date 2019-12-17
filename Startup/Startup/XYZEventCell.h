//
//  XYZEventCell.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/27/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZEventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alarmView;

@end
