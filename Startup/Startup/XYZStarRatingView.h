//
//  XYZStarRatingView.h
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/22/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZStarRatingView : UIView

@property (nonatomic) int rating;

- (id)initWithFrame:(CGRect)frame andRating:(int)rating withLabel:(BOOL)label animated:(BOOL)animated;

@end
