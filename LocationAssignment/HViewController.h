//
//  HViewController.h
//  LocationAssignment
//
//  Created by Harihar Subramanyam on 3/22/14.
//  Copyright (c) 2014 Harihar Subramanyam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface HViewController : UIViewController<MFMailComposeViewControllerDelegate, CLLocationManagerDelegate,
    MKMapViewDelegate>

@end
