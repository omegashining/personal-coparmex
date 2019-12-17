//
//  XYZMyTabBarViewController.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 2/21/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZJsonUtil.h"

#import "XYZAppDelegate.h"
#import "XYZEvaluationViewController.h"
#import "XYZLoginViewController.h"

#import "XYZMyTabBarViewController.h"

@interface XYZMyTabBarViewController ()

@property BOOL evaluation;

@end

@implementation XYZMyTabBarViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eventEvaluation) name:@"eventEvaluation" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    XYZAppDelegate *appDelegate = (XYZAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(![appDelegate authenticated])
    {
        if ([[[XYZFileUtil alloc] init] exists:@"login.json"]) {
            XYZJsonUtil *jsonUtil = [[XYZJsonUtil alloc] init];
            
            appDelegate.authenticated = YES;
            appDelegate.hash = [jsonUtil hash];
            appDelegate.date = [jsonUtil date];
            
            [self eventEvaluation];
        } else {
            [self showViewController:@"loginViewController"];
        }
    } else {
        [self eventEvaluation];
    }
}

- (void)eventEvaluation {
    XYZAppDelegate *appDelegate = (XYZAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[NSDate date] compare:appDelegate.date] == NSOrderedDescending && !self.evaluation) {
        self.evaluation = !self.evaluation;
    
        if (![[XYZFileUtil alloc] exists:@"evaluation.json"])
        {
            [self showViewController:@"evaluationViewController"];
        }
    }
}

- (void)showViewController:(NSString *)viewControllerName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerName];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
