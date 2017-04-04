//
//  ViewController.h
//  CrowdFindr
//
//  Created by Paul Dippold on 6/13/13.
//  Copyright (c) 2013 Paul Dippold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Gamekit/Gamekit.h"
#import "MessageUI/MessageUI.h"
#import "MapKit/MapKit.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@protocol ViewControllerDelegate;

@interface ViewController : UIViewController <CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate>{
    
    CLLocationCoordinate2D  currentLocation;
    CLLocationDirection     currentHeading;
    
    CLLocationCoordinate2D  cityLocation;
    CLLocationDirection     cityHeading;
    
    
  IBOutlet  MKMapView *mapView;
    CLLocationManager *locationManager;
    CLLocation *address1;
    CLLocation *address2;
    NSString *lat1;
    NSString *lat2;

    NSString *locationbearing;

    NSString *latitude1;
    NSString *latitude2;
    NSString *longitude1;
    NSString *longitude2;
    
    IBOutlet UIImageView *compass;
    
        NSString *dicturl;
    IBOutlet UILabel *locurl;
    NSArray *urlComponents;
    NSTimer *Timer1;
    
    float GeoAngle;
    
    IBOutlet UISegmentedControl *Segment;

}


@property (nonatomic) CLLocationDirection currentHeading;


@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelOne;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelTwo;
@property (retain, nonatomic) IBOutlet UILabel *locationdistance;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelfriend1;
@property (retain, nonatomic) IBOutlet UILabel *locationLabelfriend2;
@property (retain, nonatomic) IBOutlet UITextField *locationtext1;
@property (retain, nonatomic) IBOutlet UITextField *locationtext2;

-(IBAction)send:(id)sender;



@end

@protocol ViewControllerDelegate <NSObject>

- (void)settext;

@end
