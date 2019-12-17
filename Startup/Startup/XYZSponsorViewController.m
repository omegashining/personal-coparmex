//
//  XYZSponsorViewController.m
//  Coparmex
//
//  Created by Gabriel Baltazar Perez on 3/14/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZImageUtil.h"

#import "XYZSponsorViewController.h"

@interface XYZSponsorViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *urlTextView;

@end

@implementation XYZSponsorViewController

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
    
    [self.photoImageView setImage:[[XYZImageUtil alloc] getImage:self.sponsor.image ofType:@"sponsor"]];
    [self.nameLabel setText:self.sponsor.name];
    [self.urlTextView setDataDetectorTypes:UIDataDetectorTypeLink];
    [self.urlTextView setText:self.sponsor.url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
