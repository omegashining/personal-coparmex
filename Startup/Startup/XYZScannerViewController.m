//
//  XYZTarjetaViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/29/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "ZBarImageScanner.h"
#import "ZBarReaderView.h"

#import "XYZScannerViewController.h"

@interface XYZScannerViewController ()

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation XYZScannerViewController

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
    
    [self.addButton setEnabled:NO];
    
    [self.addButton addTarget:self action:@selector(addButtonHighlight:) forControlEvents:UIControlEventTouchDown];
    [self.addButton addTarget:self action:@selector(addButtonNormal:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload
{
    [self setCodeLabel:nil];
    
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

- (void)addButtonHighlight:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(68/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

- (void)addButtonNormal:(UIButton *)button {
    [button setBackgroundColor:[UIColor colorWithRed:(118/255.0) green:(178/255.0) blue:(255/255.0) alpha:1]];
}

#pragma mark - Code Reader

- (void) readerView:(ZBarReaderView *)readerView didReadSymbols: (ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    ZBarSymbol * barSymbol = nil;
    for (barSymbol in symbols)
    {
        self.code = barSymbol.data;
        self.codeLabel.text = self.code;
        
        [self.addButton setEnabled:YES];
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
    reader.frame = CGRectMake(10, 75, width-20, height-160);
    [reader start];
    
    [self.view addSubview:reader];
}

@end
