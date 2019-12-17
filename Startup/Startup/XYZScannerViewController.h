//
//  XYZTarjetaViewController.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/29/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZContact.h"
#import "ZBarSDK.h"
#import <UIKit/UIKit.h>

@interface XYZScannerViewController : UIViewController <ZBarReaderViewDelegate>
{
    ZBarReaderView * _reader;
}

@property NSString *code;

@end
