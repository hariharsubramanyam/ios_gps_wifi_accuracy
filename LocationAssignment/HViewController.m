//
//  HViewController.m
//  LocationAssignment
//
//  Created by Harihar Subramanyam on 3/22/14.
//  Copyright (c) 2014 Harihar Subramanyam. All rights reserved.
//

#import "HViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *switchUseGPS;
@property (weak, nonatomic) IBOutlet UIButton *btnTrackLocation;
@property (weak, nonatomic) IBOutlet UITextView *lblOutput;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailSelf;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapWidget;
@property (strong, nonatomic) NSMutableArray *locations;
@end

@implementation HViewController

- (IBAction)location_button_click:(id)sender {
    self.btnTrackLocation.enabled = NO;
    self.switchUseGPS.enabled = NO;
    self.btnEmailSelf.enabled = YES;
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    self.locationManager.delegate = self;
    if (self.switchUseGPS.isOn) {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1.0;
        [self.locationManager startUpdatingLocation];
    }else{
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
    CLLocation *location = self.locationManager.location;
    MKCoordinateRegion mapRegion;
    mapRegion.center.longitude = location.coordinate.longitude;
    mapRegion.center.latitude = location.coordinate.latitude;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    MKPointAnnotation *ant = [[MKPointAnnotation alloc] init];
    ant.coordinate = location.coordinate;
    ant.title = [NSDateFormatter localizedStringFromDate:location.timestamp
                                               dateStyle:NSDateFormatterNoStyle
                                               timeStyle:NSDateFormatterMediumStyle];
    [self.mapWidget addAnnotation:ant];
}


- (IBAction)email_self_click:(id)sender {
    [self.locationManager stopUpdatingLocation];
    // From within your active view controller
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"Location Results"];
        [mailCont setToRecipients:[NSArray arrayWithObject:@""]];
        [mailCont setMessageBody:self.lblOutput.text isHTML:NO];
        
        [self presentModalViewController:mailCont animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapWidget.delegate = self;
    self.lblOutput.text = @"Timestamp, Lat, Lon\n";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    self.btnTrackLocation.enabled = YES;
    self.switchUseGPS.enabled = YES;
    self.btnEmailSelf.enabled = NO;
    self.lblOutput.text = @"Timestamp, Lat, Lon\n";
    [self dismissModalViewControllerAnimated:YES];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 60.0) {
        self.lblOutput.text = [self.lblOutput.text stringByAppendingString:[NSString stringWithFormat:@"%f,%+.6f, %+.6f\n", location.timestamp.timeIntervalSince1970,
                                                                            location.coordinate.latitude,
                                                                            location.coordinate.longitude]];
        
        MKCoordinateRegion mapRegion;
        mapRegion.center.longitude = location.coordinate.longitude;
        mapRegion.center.latitude = location.coordinate.latitude;
        mapRegion.span.latitudeDelta = 0.03;
        mapRegion.span.longitudeDelta = 0.03;
        
        MKPointAnnotation *ant = [[MKPointAnnotation alloc] init];
        ant.coordinate = location.coordinate;
        ant.title = [NSDateFormatter localizedStringFromDate:location.timestamp
                                                   dateStyle:NSDateFormatterNoStyle
                                                   timeStyle:NSDateFormatterMediumStyle];
        [self.mapWidget addAnnotation:ant];
    }
}

@end
