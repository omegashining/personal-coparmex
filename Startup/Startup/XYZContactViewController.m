//
//  XYZTarjetaViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/14/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZContactViewController.h"

@interface XYZContactViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation XYZContactViewController

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
    [self.nameLabel setText:self.contact.name];
    [self.organizationLabel setText:self.contact.organization];
    [self.jobLabel setText:self.contact.job];
    [self.emailLabel setText:self.contact.email];
    [self.phoneLabel setText:self.contact.phone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
