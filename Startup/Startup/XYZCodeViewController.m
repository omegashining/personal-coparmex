//
//  XYZCodeViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/20/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "ZBarImageScanner.h"
#import "ZBarReaderView.h"

#import "XYZValidator.h"

#import "XYZContact.h"

#import "XYZCodeViewController.h"

@interface XYZCodeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation XYZCodeViewController

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
    
    [self init_camera];
    
    self.scroll.delaysContentTouches = NO;
    self.scroll.canCancelContentTouches = NO;
    
    [self.acceptButton setEnabled:NO];
    
    [self.acceptButton addTarget:self action:@selector(acceptButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.acceptButton addTarget:self action:@selector(acceptButtonNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.cancelButton addTarget:self action:@selector(cancelButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.cancelButton addTarget:self action:@selector(cancelButtonNormal:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

#pragma mark - Target Buttons

- (void)acceptButtonHighlight:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(68/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

- (void)acceptButtonNormal:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(118/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

- (void)cancelButtonHighlight:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(255/255.0) green:(35/255.0) blue:(65/255.0) alpha:1]];
}

- (void)cancelButtonNormal:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(205/255.0) green:(55/255.0) blue:(95/255.0) alpha:1]];
}

#pragma mark - Code Reader

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * barSymbol = nil;
    for (barSymbol in symbols)
    {
        self.code = barSymbol.data;
        self.codeLabel.text = self.code;
        
        [self.acceptButton setEnabled:YES];
    }
}

#pragma mark - Initialize camera

- (void) init_camera
{
    const float width = [UIScreen mainScreen].bounds.size.width;
    const float height = [UIScreen mainScreen].bounds.size.height;
    
    ZBarImageScanner * scanner = [ZBarImageScanner new];
    [scanner setSymbology:ZBAR_PARTIAL config:0 to:0];
    
    ZBarReaderView * reader = [ZBarReaderView new];
    reader.readerDelegate = self;
    reader.frame = CGRectMake(10, 30, width-20, height-160);
    [reader start];
    
    [self.view addSubview: reader];
}


@end
