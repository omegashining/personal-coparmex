//
//  XYZMyAlertView.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/23/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZValidator.h"

#import "XYZStarRatingView.h"
#import "XYZEventViewController.h"

#import "XYZAlertEvaluationView.h"

@implementation XYZAlertEvaluationView

XYZStarRatingView *starRatingView;
XYZEvent *currentEvent;
UIButton *evaluationButton;

@synthesize isShown;

- (id)initWithEvent:(XYZEvent *)event andButton:(UIButton *)button
{
    evaluationButton = button;
    currentEvent = event;
    
    CGRect frame = CGRectMake(20, 200, 280, 140);
    
    self = [super initWithFrame:frame];
    if (self) {
        originalFrame = frame;
        
        self.alpha = 0;
        self.backgroundColor = [UIColor lightGrayColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
        titleLabel.text = currentEvent.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, frame.size.width, 20)];
        messageLabel.text = @"Evalue el evento :";
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:messageLabel];
        
        starRatingView = [[XYZStarRatingView alloc] initWithFrame:CGRectMake((frame.size.width-150)/2, frame.size.height-85, 150, 30) andRating:0 withLabel:NO animated:NO];
        [self addSubview:starRatingView];
        
        UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        acceptButton.frame = CGRectMake(30, frame.size.height - 40, 100, 30);
        [acceptButton setTintColor:[UIColor colorWithRed:(0/255.0) green:(100/255.0) blue:(255/255.0) alpha:1]];
        [acceptButton setBackgroundColor:[UIColor whiteColor]];
        [acceptButton setTitle:@"Aceptar" forState:UIControlStateNormal];
        [acceptButton addTarget:self action:@selector(evaluate) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:acceptButton];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(145, frame.size.height - 40, 100, 30);
        [cancelButton setTintColor:[UIColor colorWithRed:(0/255.0) green:(100/255.0) blue:(255/255.0) alpha:1]];
        [cancelButton setBackgroundColor:[UIColor whiteColor]];
        [cancelButton setTitle:@"Cancelar" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
    }
    return self;
}


#pragma mark Custom alert methods

- (void)show
{
    isShown = YES;
    
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView beginAnimations:@"showAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)hide
{
    isShown = NO;
    
    [UIView beginAnimations:@"hideAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView commitAnimations];
    
    [evaluationButton setEnabled:YES];
}

- (void)evaluate
{
    int evaluation = starRatingView.rating / 20;
    
    if (evaluation > 0) {
        NSString *body = [NSString stringWithFormat:@"{ \"value\": \"%d\", \"event\": \"%@\" }", evaluation, currentEvent.identifier];
    
        if ([[XYZValidator alloc] sendBody:body withUrl:@"http://conferences.dotrow.com/rate"])
        {
            NSString *starsImage = [NSString stringWithFormat:@"%d_stars_yellow.png", evaluation];
            
            [evaluationButton setImage:[UIImage imageNamed:starsImage] forState:UIControlStateNormal];
            
            [currentEvent setStared:YES];
            [currentEvent setStarsImage:starsImage];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProgram" object:nil];
        }
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:currentEvent.title message:@"Debe evaluar el evento con al menos una estrella" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
    }
    
    [evaluationButton setEnabled:YES];
    
    [self hide];
}

- (void)toggle
{
    if (isShown)
    {
        [self hide];
    }
    else
    {
        [self show];
    }
}

#pragma mark Animation delegate

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"showAlert"])
    {
        if (finished)
        {
            [UIView beginAnimations:nil context:nil];
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [UIView commitAnimations];
        }
    }
    else if ([animationID isEqualToString:@"hideAlert"])
    {
        if (finished)
        {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.frame = originalFrame;
        }
    }
}

#pragma mark Touch methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    lastTouchLocation = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint newTouchLocation = [touch locationInView:self];
    CGRect currentFrame = self.frame;
    
    CGFloat deltaX = lastTouchLocation.x - newTouchLocation.x;
    CGFloat deltaY = lastTouchLocation.y - newTouchLocation.y;
    
    self.frame = CGRectMake(currentFrame.origin.x - deltaX, currentFrame.origin.y - deltaY, currentFrame.size.width, currentFrame.size.height);
    lastTouchLocation = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
