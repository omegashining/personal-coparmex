//
//  XYZLoginViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/20/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZJsonUtil.h"
#import "XYZUrlUtil.h"
#import "XYZValidator.h"

#import "XYZAppDelegate.h"
#import "XYZCodeViewController.h"

#import "XYZLoginViewController.h"

@interface XYZLoginViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *scannerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginClicked:(id)sender;
- (IBAction)backgroundClick:(id)sender;

@end

@implementation XYZLoginViewController

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

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self setCodeTextField:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Load Initial Data

- (void) initGUI
{
    self.scroll.delaysContentTouches = NO;
    self.scroll.canCancelContentTouches = NO;
    
    [self.scannerButton addTarget:self action:@selector(scannerButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.scannerButton addTarget:self action:@selector(scannerButtonNormal:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Target Buttons

- (void)scannerButtonHighlight:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(176/255.0) green:(112/255.0) blue:(255/255.0) alpha:1]];
}

- (void)scannerButtonNormal:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(176/255.0) green:(132/255.0) blue:(255/255.0) alpha:1]];
}

#pragma mark - Login Event

- (IBAction)loginClicked:(id)sender {
    [self login];
}

#pragma mark - Background Event

- (IBAction)backgroundClick:(id)sender {
    [self.codeTextField resignFirstResponder];
}

#pragma mark - Unwind Accept

- (IBAction)unwindAccept:(UIStoryboardSegue *)segue
{
    XYZCodeViewController *source = [segue sourceViewController];
    self.codeTextField.text = source.code;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [self login];
}

#pragma mark - Unwind Cancel

- (IBAction)unwindCancel:(UIStoryboardSegue *)segue
{
}

#pragma mark - Login

- (void)login
{
    NSString *stringUrl = [NSString stringWithFormat:@"http://conferences.dotrow.com/signin/%@", self.codeTextField.text];
    
    if ([[XYZValidator alloc] validateStringUrl:stringUrl])
    {
        NSData *data = [[XYZUrlUtil alloc] dataFrom:stringUrl];
        
        if (data != nil)
        {
            [[XYZFileUtil alloc] saveData:data inFile:@"login.json"];
            
            XYZAppDelegate *appDelegate = (XYZAppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.authenticated = YES;
            appDelegate.hash = [[XYZJsonUtil alloc] hash];
            appDelegate.date = [[XYZJsonUtil alloc]  date];
            
            [self showNotification:appDelegate.date];
            
            [self dismissViewControllerAnimated:NO completion:nil];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudo autentificar el código de registro." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil] show];
        }
    }
}

#pragma mark - Send Local Notification

- (void)showNotification:(NSDate *)date
{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [date dateByAddingTimeInterval:10];
    localNotification.alertBody = @"Por favor evalua el evento.";
    localNotification.alertAction = @"Evaluación Coparmex";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
