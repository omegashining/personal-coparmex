//
//  XYZCodeViewController.h
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/20/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "ZBarSDK.h"
#import <UIKit/UIKit.h>

@interface XYZCodeViewController : UIViewController <ZBarReaderViewDelegate>
{
    ZBarReaderView * _reader;
}

@property NSString *code;

@end
