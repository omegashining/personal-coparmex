//
//  XYZFrontViewController.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 2/21/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"

#import "XYZAppDelegate.h"
#import "XYZLoginViewController.h"

#import "XYZFrontViewController.h"

@interface XYZFrontViewController ()

@property (weak, nonatomic) IBOutlet UIButton *exitButton;

- (IBAction)exitClicked:(id)sender;

@end

@implementation XYZFrontViewController

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
    
    [self.exitButton setHidden:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Exit Event

- (IBAction)exitClicked:(id)sender {
    XYZAppDelegate *appDelegate = (XYZAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.authenticated = NO;
    appDelegate.hash = nil;
    
    XYZFileUtil *fileUtil = [[XYZFileUtil alloc] init];
    [fileUtil deleteFile:@"login.json"];
    
    [self showViewController:@"loginViewController"];
}

- (void)showViewController:(NSString *)viewControllerName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerName];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

@end
