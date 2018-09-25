#import <XCTest/XCTest.h>
#import <CoreLocation/CoreLocation.h>
#import <Mapbox/Mapbox.h>
#import <MapKit/MapKit.h>

@interface MGLMapCameraTests : XCTestCase

@end

@implementation MGLMapCameraTests

- (void)testViewingDistance {
    CLLocationCoordinate2D fountainSquare = CLLocationCoordinate2DMake(39.10152215, -84.5124439696089);
    MGLMapCamera *camera = [MGLMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                                   correctlyFromDistance:10000
                                                                   pitch:0
                                                                 heading:0];
    MKMapCamera *mkCamera = [MKMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                                            fromDistance:10000
                                                                   pitch:0
                                                                 heading:0];
    XCTAssertEqualWithAccuracy(camera.altitude, 10000, 0.01, @"Untilted camera should use distance verbatim.");
    XCTAssertEqualWithAccuracy(camera.altitude, mkCamera.altitude, 0.01, @"Untilted camera altitude should match MapKit.");
    
    camera = [MGLMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                                  altitude:10000
                                                     pitch:0
                                                   heading:0];
    XCTAssertEqual(camera.altitude, 10000, @"Untilted camera should use altitude verbatim.");
    
    camera = [MGLMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                     correctlyFromDistance:10000
                                                     pitch:60
                                                   heading:0];
    mkCamera = [MKMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                               fromDistance:10000
                                                      pitch:60
                                                    heading:0];
    XCTAssertEqualWithAccuracy(camera.altitude, 5000, 0.01, @"Tilted camera altitude should account for pitch.");
    XCTAssertEqualWithAccuracy(camera.altitude, mkCamera.altitude, 0.01, @"Tilted camera altitude should match MapKit.");
    
    camera = [MGLMapCamera cameraLookingAtCenterCoordinate:fountainSquare
                                                  altitude:10000
                                                     pitch:60
                                                   heading:0];
    XCTAssertEqual(camera.altitude, 10000, @"Tilted camera should use altitude verbatim.");
}

@end
