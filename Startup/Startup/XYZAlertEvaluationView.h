//
//  XYZMyAlertView.h
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/23/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZEvent.h"

#import <UIKit/UIKit.h>

@interface XYZAlertEvaluationView : UIView {
    CGPoint lastTouchLocation;
    CGRect originalFrame;
    BOOL isShown;
}

@property (nonatomic) BOOL isShown;

- (void)show;
- (void)hide;

- (id)initWithEvent:(XYZEvent *)event andButton:(UIButton *)button;

@end
