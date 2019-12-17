//
//  XYZMapaEventoViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/3/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZJsonUtil.h"

#import "XYZSponsor.h"
#import "XYZSponsorViewController.h"

#import "XYZMapViewController.h"

@interface XYZMapViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XYZMapViewController

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"mapa"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - WebView delegate method

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *sheme = [[request URL] scheme];
    
    if ([sheme hasPrefix:@"sponsor"])
    {
        NSURL *absoluteURL = [request.mainDocumentURL absoluteURL];
        NSString *absoluteString = [absoluteURL absoluteString];
        
        self.idSponsor = [absoluteString substringFromIndex:8];
        
        [self performSegueWithIdentifier:@"sponsor" sender:self];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Show event information in other view

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"sponsor"])
    {
        [[XYZFileUtil alloc] saveUrlContent:@"http://conferences.dotrow.com/_sponsors.json" inFile:@"sponsors.json"];
        
        XYZSponsorViewController *source = [segue destinationViewController];
        
        for (NSMutableArray *section in [[XYZJsonUtil alloc] sponsorsFrom:@"sponsors.json"]) {
            for (XYZSponsor *sponsor in section) {
                if ([self.idSponsor isEqualToString:sponsor.identifier]) {
                    source.sponsor = sponsor;
                    break;
                }
            }
        }
    }
}

@end
