//
//  XYZPatrocinadoresViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 1/23/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZImageUtil.h"
#import "XYZJsonUtil.h"

#import "XYZAppDelegate.h"
#import "XYZSponsor.h"
#import "XYZSponsorCell.h"
#import "XYZSponsorViewController.h"

#import "XYZSponsorsViewController.h"

@interface XYZSponsorsViewController ()

@property (strong, nonatomic) IBOutlet UIRefreshControl *refresh;
@property (weak, nonatomic) IBOutlet UITableView *tvSponsors;

@end

@implementation XYZSponsorsViewController

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
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Initialize GUI

- (void)initGUI
{
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] init];
    [self.refresh addTarget:self action:@selector(refresData) forControlEvents:UIControlEventValueChanged];
    
    [self.tvSponsors addSubview:self.refresh];
}

#pragma mark - Load Initial Data

- (void)initData
{
    [[XYZFileUtil alloc] saveUrlContent:@"http://conferences.dotrow.com/_sponsors.json" inFile:@"sponsors.json"];
    
    self.headers = [[NSArray alloc] initWithObjects:@"Patrocinadores", @"Aliados Estratégicos", @"Instituciones de Apoyo", nil];
    
    self.sponsors = [[XYZJsonUtil alloc] sponsorsFrom:@"sponsors.json"];
    
    [self.tvSponsors performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"sponsor"])
    {
        NSIndexPath *indexPath = [self.tvSponsors indexPathForSelectedRow];
        
        XYZSponsorViewController *source = [segue destinationViewController];
        source.sponsor = [[self.sponsors objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZSponsor *sponsor = [[self.sponsors objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    XYZSponsorCell *sponsorCell = (XYZSponsorCell *) [self.tvSponsors dequeueReusableCellWithIdentifier:@"SponsorTableCell"];
    sponsorCell.logoImageView.image = [UIImage imageNamed:@"white.jpg"];
    sponsorCell.nameLabel.text = sponsor.name;
    sponsorCell.urlLabel.text = sponsor.url;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [[XYZImageUtil alloc] getImage:sponsor.image ofType:@"sponsor"];
        
        if (image != nil)
        {
            [sponsorCell.logoImageView performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:YES];
            [sponsorCell.logoImageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
        }
    });
    
    return sponsorCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sponsors count];
}

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section
{
    return [self.headers objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.sponsors objectAtIndex:section] count];
}

#pragma mark - Refres Data in Table

- (void)refresData {
    [[XYZFileUtil alloc] saveUrlContent:@"http://conferences.dotrow.com/_sponsors.json" updateFile:@"sponsors.json"];
    
    [self initData];
    
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
}

- (void)stopRefresh {
    [self.refresh endRefreshing];
}

@end
