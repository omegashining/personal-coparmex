//
//  XYZEvaluationViewController.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/22/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZValidator.h"

#import "XYZStarRatingView.h"

#import "XYZEvaluationViewController.h"

#define kStarViewHeight 20.0f
#define kStarViewWidth 100.0f

@interface XYZEvaluationViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) XYZStarRatingView *allEvent;
@property (strong, nonatomic) XYZStarRatingView *conferences;
@property (strong, nonatomic) XYZStarRatingView *networkingActivities;
@property (strong, nonatomic) XYZStarRatingView *eventOrganization;

@property (weak, nonatomic) IBOutlet UIButton *webPageButton;
@property (weak, nonatomic) IBOutlet UIButton *socialNetworkButton;
@property (weak, nonatomic) IBOutlet UIButton *mailButton;
@property (weak, nonatomic) IBOutlet UIButton *newspaperButton;
@property (weak, nonatomic) IBOutlet UIButton *radioButton;
@property (weak, nonatomic) IBOutlet UIButton *recommendationButton;
@property (weak, nonatomic) IBOutlet UITextField *improvementTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)webPageClicked:(id)sender;
- (IBAction)socialNetworkClicked:(id)sender;
- (IBAction)mailClicked:(id)sender;
- (IBAction)newspaperClicked:(id)sender;
- (IBAction)radioClicked:(id)sender;
- (IBAction)recommendationClicked:(id)sender;
- (IBAction)sendClicked:(id)sender;

@end

@implementation XYZEvaluationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initGUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Initialize GUI
- (void)initGUI
{
    self.allEvent = [[XYZStarRatingView alloc] initWithFrame:CGRectMake(25, 110, kStarViewWidth, kStarViewHeight) andRating:0 withLabel:NO animated:NO];
    [self.scroll addSubview:self.allEvent];
    
    self.conferences = [[XYZStarRatingView alloc] initWithFrame:CGRectMake(25, 140, kStarViewWidth, kStarViewHeight) andRating:0 withLabel:NO animated:NO];
    [self.scroll addSubview:self.conferences];
    
    self.networkingActivities = [[XYZStarRatingView alloc] initWithFrame:CGRectMake(25, 170, kStarViewWidth, kStarViewHeight) andRating:0 withLabel:NO animated:NO];
    [self.scroll addSubview:self.networkingActivities];
    
    self.eventOrganization = [[XYZStarRatingView alloc] initWithFrame:CGRectMake(25, 200, kStarViewWidth, kStarViewHeight) andRating:0 withLabel:NO animated:NO];
    [self.scroll addSubview:self.eventOrganization];
    
    self.scroll.delaysContentTouches = NO;
    self.scroll.canCancelContentTouches = NO;
    
    [self.sendButton addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.sendButton addTarget:self action:@selector(buttonNormal:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Background Event

- (IBAction)improvementClick:(id)sender {
    [self.improvementTextField resignFirstResponder];
}

#pragma mark - Targets for Buttons

- (void)buttonHighlight:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(68/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

- (void)buttonNormal:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(118/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

#pragma mark - Check Events

- (IBAction)webPageClicked:(id)sender {
    [self changeStateOthers:1];
    [self changeState:sender];
}

- (IBAction)socialNetworkClicked:(id)sender {
    [self changeStateOthers:2];
    [self changeState:sender];
}

- (IBAction)mailClicked:(id)sender {
    [self changeStateOthers:3];
    [self changeState:sender];
}

- (IBAction)newspaperClicked:(id)sender {
    [self changeStateOthers:4];
    [self changeState:sender];
}

- (IBAction)radioClicked:(id)sender {
    [self changeStateOthers:5];
    [self changeState:sender];
}

- (IBAction)recommendationClicked:(id)sender {
    [self changeStateOthers:6];
    [self changeState:sender];
}

#pragma mark - Change state buttons

- (void)changeStateOthers:(int)button {
    if (button != 1) {
        if ([self.webPageButton isSelected]) {
            [self changeState:self.webPageButton];
        }
    }
    if (button != 2) {
        if ([self.socialNetworkButton isSelected]) {
            [self changeState:self.socialNetworkButton];
        }
    }
    if (button != 3) {
        if ([self.mailButton isSelected]) {
            [self changeState:self.mailButton];
        }
    }
    if (button != 4) {
        if ([self.newspaperButton isSelected]) {
            [self changeState:self.newspaperButton];
        }
    }
    if (button != 5) {
        if ([self.radioButton isSelected]) {
            [self changeState:self.radioButton];
        }
    }
    if (button != 6) {
        if ([self.recommendationButton isSelected]) {
            [self changeState:self.recommendationButton];
        }
    }
}

- (void)changeState:(id)sender {
    if ([sender isSelected]) {
        [sender setImage:[UIImage imageNamed:@"check_box_unset.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    } else {
        [sender setImage:[UIImage imageNamed:@"check_box_set.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
}

#pragma mark - Selected Button

- (NSString *)selectedButtonText {
    if ([self.webPageButton isSelected]) {
        return @"Página Web";
    }
    if ([self.socialNetworkButton isSelected]) {
        return @"Redes Sociales";
    }
    if ([self.mailButton isSelected]) {
        return @"Mail";
    }
    if ([self.newspaperButton isSelected]) {
        return @"Periódico";
    }
    if ([self.radioButton isSelected]) {
        return @"Radio";
    }
    if ([self.recommendationButton isSelected]) {
        return @"Recomendación";
    }
    
    return @"";
}

#pragma mark - Validate Evaluation

- (BOOL)validateEvaluation
{
    BOOL stars = (self.allEvent.rating / 20 != 0);
    stars = stars && (self.conferences.rating / 20 != 0);
    stars = stars && (self.networkingActivities.rating / 20 != 0);
    stars = stars && (self.eventOrganization.rating / 20 != 0);
    
    BOOL option = ![[self selectedButtonText] isEqualToString:@""];
    
    BOOL improvement = (self.improvementTextField.text != nil) && ![self.improvementTextField.text isEqualToString:@""];
    
    return stars && option && improvement;
}

#pragma mark - Send Evaluation

- (IBAction)sendClicked:(id)sender {
    if ([self validateEvaluation]) {
        NSString *body = [NSString stringWithFormat:@"{ \"rateEvent\": \"%d\", \"rateConfe\": \"%d\", \"rateNetwo\": \"%d\", \"rateOrgan\": \"%d\", \"option\": \"%@\", \"comment\": \"%@\" }", self.allEvent.rating / 20, self.conferences.rating / 20, self.networkingActivities.rating / 20, self.eventOrganization.rating / 20, [self selectedButtonText], self.improvementTextField.text];
        
        if ([[XYZValidator alloc] sendBody:body withUrl:@"http://conferences.dotrow.com/evaluate"])
        {
            [[XYZFileUtil alloc] saveData:[NSData data] inFile:@"evaluation.json"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[[UIAlertView alloc] initWithTitle:@"Evaluación" message:@"Gracias por realizar la evaluación del evento." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Evaluación" message:@"Porfavor contesta todas las opciones." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
    }
}

#pragma mark - Focus the when text field is editing

#define kOFFSET_FOR_KEYBOARD 160.0

-(void)keyboardWillShow {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.improvementTextField])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
