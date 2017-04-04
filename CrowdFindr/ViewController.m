//
//  ViewController.m
//  CrowdFindr
//
//  Created by Paul Dippold on 6/13/13.
//  Copyright (c) 2013 Paul Dippold. All rights reserved.
//

#import "ViewController.h"
#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define toRad(X) (X*M_PI/180.0)
#define toDeg(X) (X*180.0/M_PI)

@interface ViewController () 

@end

@implementation ViewController
@synthesize locationManager;
@synthesize locationLabelOne;
@synthesize locationLabelTwo;
@synthesize locationdistance;
@synthesize locationLabelfriend1;
@synthesize locationLabelfriend2;
@synthesize locationtext1;
@synthesize locationtext2;
@synthesize currentHeading;


NSTimer *Timer1;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)locurl {
    [locurl setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"url"]];
    dicturl = locurl.text;
    
    NSURL *url = [NSURL URLWithString:dicturl];
    
    [locationLabelfriend1 setText:[NSString stringWithFormat:@"%@", [url host]]];
     [locationLabelfriend2 setText:[NSString stringWithFormat:@"%@", [url query]]];
    
    NSLog(@"scheme: %@", [url scheme]);
    NSLog(@"host: %@", [url host]);
    NSLog(@"port: %@", [url port]);
    NSLog(@"path: %@", [url path]);
    NSLog(@"path components: %@", [url pathComponents]);
    NSLog(@"parameterString: %@", [url parameterString]);
    NSLog(@"query: %@", [url query]);
    NSLog(@"fragment: %@", [url fragment]);
    
    [self calculate];

}


-(IBAction)send:(id)sender{
    
    NSString *actionSheetTitle = @"Send"; //Action Sheet Title
    NSString *other1 = @"Text Location";
    NSString *other2 = @"Tweet Location";
    NSString *other3 = @"Info";
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionSheetTitle
															 delegate:self
													cancelButtonTitle:cancelTitle
											   destructiveButtonTitle:nil
													otherButtonTitles:other1, other2, other3, nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Text Location"]) {
        [self sendSMS:[NSString stringWithFormat:@"crowdfindr://%@?%@", locationLabelOne.text, locationLabelTwo.text] recipientList:nil];
    }
    if ([buttonTitle isEqualToString:@"Tweet Location"]) {
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        // Set the initial tweet text. See the framework for additional properties that can be set.
        NSString  *mystring3 = [NSString stringWithFormat:@"crowdfindr://%@?%@", locationLabelOne.text, locationLabelTwo.text];
        [tweetViewController setInitialText:mystring3];
        // Create the completion handler block.
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
            // Dismiss the tweet composition view controller.
            [self dismissModalViewControllerAnimated:YES];
        }];
        // Present the tweet composition view controller modally.
        [self presentModalViewController:tweetViewController animated:YES];
    }
    if ([buttonTitle isEqualToString:@"Info"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Send"
                                                        message:@"Sending your location will result in a url in the form of crowdfindr://xx.xxxxxx?-xx.xxxxxx. This url  can be clicked on to find that location in the Crowdfindr app."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    if ([buttonTitle isEqualToString:@"Cancel Button"]) {
    }
    
}



- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = bodyOfMessage;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled)
        NSLog(@"Message cancelled");
        else if (result == MessageComposeResultSent)
            NSLog(@"Message sent");
            else 
                NSLog(@"Message failed");  
                }


- (void)viewDidLoad
{

    Timer1 = [NSTimer scheduledTimerWithTimeInterval: 3
                                              target: self
                                            selector: @selector(locurl)
                                            userInfo: nil
                                             repeats: YES];
        
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    [locationManager startUpdatingHeading];

        [super viewDidLoad];
    
    
    }


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    [locationLabelOne setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.latitude]];
    [locationLabelTwo setText:[NSString stringWithFormat:@"%f", newLocation.coordinate.longitude]];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    [locationtext2 resignFirstResponder];
}

- (void)calculate {
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
	locationManager.headingFilter = 1;
	locationManager.delegate=self;
	[locationManager startUpdatingHeading];
    
    
    latitude1 = locationLabelfriend1.text;
    latitude2 = locationLabelfriend2.text;
    longitude1 = locationLabelOne.text;
    longitude2 = locationLabelTwo.text;
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:[latitude1 doubleValue] longitude:[latitude2 doubleValue]];
    
    // get CLLocation for both addresses
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:[longitude1 doubleValue] longitude:[longitude2 doubleValue]];
    
    
    currentLocation = location1.coordinate;
    cityLocation = LocationAtual.coordinate;
    cityHeading = [self directionFrom:currentLocation to:cityLocation];
    
    // returns a double in meters
    CLLocationDistance distance = [location1 distanceFromLocation:LocationAtual];
    
    lat1 = [NSString stringWithFormat:@"%f", distance];
    
   // double bearing1 = [location1 bearingToLocation:LocationAtual];
    
   // locationbearing = [NSString stringWithFormat:@"%f", distance];

    if(Segment.selectedSegmentIndex == 0){
        float distancevalue = [lat1 floatValue];
        float distancevalueconverted = distancevalue*3.28;
        [locationdistance setText:[NSString stringWithFormat:@"%.f feet", distancevalueconverted]];
		
	}
	if(Segment.selectedSegmentIndex == 1){
        float distancevalue = [lat1 floatValue];
        [locationdistance setText:[NSString stringWithFormat:@"%.f meters", distancevalue]];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    double heading = newHeading.trueHeading; //in degree relative to true north
    // Animate Pointer
    [UIView     animateWithDuration:0.6
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             CGAffineTransform headingRotation;
                             headingRotation = CGAffineTransformRotate(CGAffineTransformIdentity, (CGFloat)toRad(cityHeading)-toRad(heading));
                             compass.transform = headingRotation;
                         }
                         completion:^(BOOL finished) {
                             
                         }];

}
-(CLLocationDirection) directionFrom: (CLLocationCoordinate2D) startPt to:(CLLocationCoordinate2D) endPt {
    double lati1 = toRad(startPt.latitude);
    double lati2 = toRad(endPt.latitude);
    double loni1 = toRad(startPt.longitude);
    double loni2 = toRad(endPt.longitude);
    double dLon = (loni2-loni1);
    
    double y = sin(dLon) * cos(lati2);
    double x = cos(lati1) * sin(lati2) - sin(lati1) * cos(lati2) * cos(dLon);
    double brng = toDeg(atan2(y, x));
    
    brng = (brng+360);
    brng = (brng>360)? (brng-360) : brng;
    
    return brng;
}


@end
