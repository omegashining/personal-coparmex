//
//  XYZTarjetasViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 2/4/14.
//  Copyright (c) 2014 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZJsonUtil.h"
#import "XYZUrlUtil.h"
#import "XYZValidator.h"

#import "XYZContact.h"
#import "XYZContactCell.h"
#import "XYZContactViewController.h"
#import "XYZScannerViewController.h"

#import "XYZContactsViewController.h"

@interface XYZContactsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tvContacts;

@end

@implementation XYZContactsViewController

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
    
    [self initData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Load Initial Data

- (void) initData
{
    if ([[XYZFileUtil alloc] exists:@"contacts.json"]) {
        self.contacts = [[XYZJsonUtil alloc] contactsFrom:@"contacts.json"];
        
        [self.tvContacts performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    } else {
        self.contacts = [[NSMutableArray alloc] init];
    }
}

#pragma mark - Unwind Events

- (IBAction)unwindContact:(UIStoryboardSegue *)segue
{
    XYZScannerViewController *source = [segue sourceViewController];
    
    NSString *stringUrl = [NSString stringWithFormat:@"http://conferences.dotrow.com/api/users/%@", source.code];
    
    if ([[XYZValidator alloc] validateStringUrl:stringUrl])
    {
        NSData *data = [[XYZUrlUtil alloc] dataFrom:stringUrl];
        
        [[XYZJsonUtil alloc] addContactFrom:data to:self.contacts];
        
        [self.tvContacts reloadData];
    }
}

#pragma mark - Segue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"contact"])
    {
        XYZContactViewController *source = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tvContacts indexPathForSelectedRow];
        source.contact = [self.contacts objectAtIndex:[indexPath row]];
    }
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZContactCell *contactCell = (XYZContactCell *) [self.tvContacts dequeueReusableCellWithIdentifier:@"ContactTableCell"];
    
    XYZContact *contact = [self.contacts objectAtIndex:indexPath.row];
    contactCell.nameLabel.text = contact.name;
    contactCell.emailLabel.text = contact.email;
    
    return contactCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contacts count];
}

@end
