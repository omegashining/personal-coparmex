//
//  XYZProximosEventosViewController.m
//  Startup
//
//  Created by Gabriel Baltazar Perez on 12/26/13.
//  Copyright (c) 2013 Gabriel Baltazar Perez. All rights reserved.
//

#import "XYZFileUtil.h"
#import "XYZJsonUtil.h"
#import "XYZUrlUtil.h"

#import "XYZEvent.h"
#import "XYZEventCell.h"
#import "XYZEventViewController.h"

#import "XYZAgendaViewController.h"

@interface XYZAgendaViewController ()

@property (strong, nonatomic) IBOutlet  UIRefreshControl *refresh;

@property (weak, nonatomic) IBOutlet UIButton *conferencesButton;
@property (weak, nonatomic) IBOutlet UIButton *standsButton;
@property (weak, nonatomic) IBOutlet UISearchBar *sbEvent;
@property (weak, nonatomic) IBOutlet UITableView *tvEvents;

- (IBAction)conferencesClicked:(id)sender;
- (IBAction)standsClicked:(id)sender;

@end

@implementation XYZAgendaViewController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:@"refreshProgram" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Initialize the GUI

- (void) initGUI
{
    /* SEARCH BAR */
    
    // Hide the search bar until user scrolls up
    CGRect newBounds = [[self tvEvents] bounds];
    newBounds.origin.y = newBounds.origin.y + self.sbEvent.bounds.size.height;
    [[self tvEvents] setBounds:newBounds];
    
    /* TABLE VIEW FILTER */
    
    UITableView *tvEventsFiltering = self.searchDisplayController.searchResultsTableView;
    [tvEventsFiltering setSeparatorColor:[UIColor lightGrayColor]];
    [tvEventsFiltering setRowHeight:67.0];
    
    /* REFRES CONTROL */
    
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] init];
    [self.refresh addTarget:self action:@selector(refresData) forControlEvents:UIControlEventValueChanged];
    
    [self.tvEvents addSubview:self.refresh];
}

#pragma mark - Load Initial Data

- (void) initData
{
    [[XYZFileUtil alloc] saveUrlContent:@"http://conferences.dotrow.com/_events.json" inFile:@"events.json"];
    
    self.events = [[XYZJsonUtil alloc] eventsFrom:@"events.json"];
    
    [self filterTableWithType:@"conference"];
}

#pragma mark - Show event information in other view

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"event"])
    {
        NSIndexPath *indexPath;
        XYZEvent *selectedEvent;
        if(sender == self.searchDisplayController.searchResultsTableView)
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            selectedEvent = [self.searchEvents objectAtIndex:[indexPath row]];
        }
        else
        {
            indexPath = [self.tvEvents indexPathForSelectedRow];
            selectedEvent = [self.filterEvents objectAtIndex:[indexPath row]];
        }
        
        XYZEventViewController *source = [segue destinationViewController];
        for (XYZEvent *event in self.events) {
            if ([event.identifier isEqualToString:selectedEvent.identifier]) {
                source.event = event;
            }
        }
    }
}

#pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"event" sender:tableView];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableView == self.searchDisplayController.searchResultsTableView) ? [self.searchEvents count] : [self.filterEvents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZEvent *event = (tableView == self.searchDisplayController.searchResultsTableView) ? [self.searchEvents objectAtIndex:indexPath.row] : [self.filterEvents objectAtIndex:indexPath.row];
    
    XYZEventCell *eventCell = (XYZEventCell *) [self.tvEvents dequeueReusableCellWithIdentifier:@"EventTableCell"];
    eventCell.hourLabel.text = [event.startDate substringFromIndex:[event.startDate length]-5];
    eventCell.titleLabel.text = event.title;
    eventCell.locationLabel.text = [event.location uppercaseString];
    eventCell.alarmView.image = event.alarm ? [UIImage imageNamed:@"alarm_icon.png"] : nil;
    
    return eventCell;
}

#pragma mark - Filter Content by title

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@",searchText];
    NSArray *tempArray = [self.filterEvents filteredArrayUsingPredicate:predicate];
    
    self.searchEvents = [NSMutableArray arrayWithArray:tempArray];
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

#pragma mark - Search Events (Reveal search bar when search button is pressed)

- (IBAction)goToSearch:(id)sender
{
    [self.tvEvents setContentOffset:CGPointMake(0, -65) animated:NO];
    [self.sbEvent becomeFirstResponder];
}

#pragma mark - Conferences Event

- (IBAction)conferencesClicked:(id)sender {
    if (!self.conferences)
    {
        [self filterTableWithType:@"conference"];
    }
}

#pragma mark - Stands Event

- (IBAction)standsClicked:(id)sender {
    if (self.conferences)
    {
        [self filterTableWithType:@"stand"];
    }
}

#pragma mark - Filter Table with any type

- (void)filterTableWithType:(NSString *)type {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.type contains[c] %@", type];
    NSArray *tempArray = [self.events filteredArrayUsingPredicate:predicate];
    
    self.filterEvents = [NSMutableArray arrayWithArray:tempArray];
    
    [self.tvEvents performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
    
    if ([type isEqualToString:@"conference"])
    {
        [self.conferencesButton setTintColor:[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1]];
        [self.standsButton setTintColor:[UIColor blackColor]];
        
        self.conferences = YES;
    }
    else
    {
        [self.conferencesButton setTintColor:[UIColor blackColor]];
        [self.standsButton setTintColor:[UIColor colorWithRed:(0/255.0) green:(122/255.0) blue:(255/255.0) alpha:1]];
        
        self.conferences = NO;
    }
}

#pragma mark - Refresh Table

- (void)refresh:(NSNotification *)notification
{
    [self.tvEvents reloadData];
    
    UITableView *tvEventsFiltering = self.searchDisplayController.searchResultsTableView;
    [tvEventsFiltering reloadData];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [[XYZJsonUtil alloc] eventsDataFrom:self.events];
        
        [[XYZFileUtil alloc] saveData:data inFile:@"events.json"];
    });
}

#pragma mark - Refres Content Data in Table

- (void)refresData
{
    [[XYZFileUtil alloc] saveUrlContent:@"http://conferences.dotrow.com/_events.json" inFile:@"uevents.json"];
    
    NSMutableArray *uevents = [[XYZJsonUtil alloc] eventsFrom:@"uevents.json"];
    
    BOOL exists = NO;
    for (XYZEvent *uevent in uevents)
    {
        for (XYZEvent *event in self.events)
        {
            if ([event.identifier isEqualToString:uevent.identifier])
            {
                event.type = uevent.type;
                event.title = uevent.title;
                event.startDate = uevent.startDate;
                event.endDate = uevent.endDate;
                event.location = uevent.location;
                event.description = uevent.description;
                event.image = uevent.image;
                event.author = uevent.author;
                event.organization = uevent.organization;
                
                exists = YES;
            }
        }
                
        if (!exists)
        {
            [self.events addObject:uevent];
        }
        
        exists = NO;
    }
    
    [self filterTableWithType:@"conference"];
    
    [self refresh:nil];
    
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
}

- (void)stopRefresh
{
    [self.refresh endRefreshing];
}

@end
