//
//  XYZEventoViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/3/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import <EventKit/EventKit.h>

#import "XYZFileUtil.h"
#import "XYZImageUtil.h"
#import "XYZValidator.h"

#import "XYZAlertEvaluationView.h"

#import "XYZEventViewController.h"

@interface XYZEventViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *datetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speakersLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *evaluationButton;

@property XYZAlertEvaluationView *alertEvaluation;

- (IBAction)alarmClicked:(id)sender;
- (IBAction)commentClicked:(id)sender;
- (IBAction)evaluationClicked:(id)sender;

@end

@implementation XYZEventViewController

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
    
    [self.imageView setImage:[UIImage imageNamed:@"white.jpg"]];
    [self.titleLabel setText:self.event.title];
    [self.datetimeLabel setText:[NSString stringWithFormat:@"%@ Hrs.", [self.event.startDate substringFromIndex:[self.event.startDate length]-5]]];
    [self.locationLabel setText:self.event.location];
    [self.speakersLabel setText:self.event.author];
    [self.descriptionLabel setText:self.event.description];
    
    if (self.event.alarm) {
        [self.alarmButton setImage:[UIImage imageNamed:@"alarm_button_set.png"] forState:UIControlStateNormal];
    }
    
    if (self.event.stared) {
        [self.evaluationButton setImage:[UIImage imageNamed:self.event.starsImage] forState:UIControlStateNormal];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        XYZImageUtil *imageUtil = [[XYZImageUtil alloc] init];
        
        UIImage *image = [imageUtil getImage:self.event.image ofType:@"conference"];
        
        if (image != nil) {
            [self.imageView performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:YES];
            [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark = Event Alarm

- (IBAction)alarmClicked:(id)sender {;
    if (self.event.alarm) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyy HH:mm"];
        
        EKEventStore *store = [[EKEventStore alloc] init];
        NSPredicate *predicate = [store predicateForEventsWithStartDate:[dateFormat dateFromString:@"08/04/2014 00:00"] endDate:[dateFormat dateFromString:@"08/04/2014 23:59"] calendars:nil];
        
        for (EKEvent *eventToCheck in [store eventsMatchingPredicate:predicate]) {
            if ([eventToCheck.title isEqualToString:self.event.title]) {
                self.idEvent = eventToCheck.eventIdentifier;
            }
        }
        
        store = [[EKEventStore alloc] init];
        
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted)
            {
                return;
            }
            
            EKEvent* eventToRemove = [store eventWithIdentifier:self.idEvent];
            
            if (eventToRemove)
            {
                [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:nil];
            }
        }];
        
        [self.alarmButton setImage:[UIImage imageNamed:@"alarm_button_unset.png"] forState:UIControlStateNormal];
    } else {
        EKEventStore *store = [[EKEventStore alloc] init];
        
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (!granted)
            {
                return;
            }
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"dd/MM/yyy HH:mm"];
            
            EKEvent *eventToAdd = [EKEvent eventWithEventStore:store];
            eventToAdd.title = self.event.title;
            eventToAdd.startDate = [dateFormat dateFromString:self.event.startDate];
            eventToAdd.endDate = [eventToAdd.startDate dateByAddingTimeInterval:60 * 60];
            
            [eventToAdd addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];
            [eventToAdd setCalendar:[store defaultCalendarForNewEvents]];
            
            [store saveEvent:eventToAdd span:EKSpanThisEvent commit:YES error:nil];
        }];
        
        [self.alarmButton setImage:[UIImage imageNamed:@"alarm_button_set.png"] forState:UIControlStateNormal];
    }
    
    self.event.alarm = !self.event.alarm;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshProgram" object:nil];
}

#pragma mark = Event Comment

- (IBAction)commentClicked:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:self.event.title message:@"Escribe tu comentario :" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Enviar", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
}

#pragma mark = Event Evaluation

- (IBAction)evaluationClicked:(id)sender {
    if (self.event.stared)
    {
        [[[UIAlertView alloc] initWithTitle:self.event.title message:@"El evento ya ha sido evaluado" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
    }
    else
    {
        [self.evaluationButton setEnabled:NO];
        
        self.alertEvaluation = [[XYZAlertEvaluationView alloc] initWithEvent:self.event andButton:self.evaluationButton];
        [self.view addSubview:self.alertEvaluation];
        [self.alertEvaluation show];
    }
}

#pragma mark - Alert Comment

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *comment = [alertView textFieldAtIndex:0].text;
        NSString *body = [NSString stringWithFormat:@"{ \"text\": \"%@\", \"event\": \"%@\" }", comment, self.event.identifier];
        
        if ([[XYZValidator alloc] sendBody:body withUrl:@"http://conferences.dotrow.com/comment"])
        {
            [[[UIAlertView alloc] initWithTitle:self.event.title message:@"Gracias por su comentario" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
        }
    }
}

@end
