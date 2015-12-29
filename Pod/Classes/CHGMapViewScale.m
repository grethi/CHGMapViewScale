//
//  FOGMapViewScale.m
//  PinYa
//
//  Created by Christian on 22.12.15.
//  Copyright © 2015 fog. All rights reserved.
//

#import "CHGMapViewScale.h"

#import "NSTimer+BlocksKit.h"

@implementation CHGMapViewScale {
    UIView *_scale;
    UILabel *_scaleLabel;
    GMSMapView *_mapView;
    NSDictionary *_scaleText;
    NSTimer *updateTimer;
}

- (instancetype)initWithMapView:(GMSMapView *)mapView
{
    self = [super init];
    if (self) {
        _mapView = mapView;
        
        self.viewToScaleRatio = 0.2f;
        self.scaleColor = [UIColor blackColor];
        self.scaleTextColor = [UIColor blackColor];
        self.scaleTextAlignement = NSTextAlignmentRight;
        
        _scale = [[UIView alloc] init];
        [self addSubview:_scale];
        
        _scaleLabel = [[UILabel alloc] init];
        _scaleLabel.font = [_scaleLabel.font fontWithSize:9.f];
        [self addSubview:_scaleLabel];
        
        
        [self update];
        
        [_mapView addSubview:self];
    }
    return self;
}

- (void)update
{
    [updateTimer invalidate];
    
    updateTimer = [NSTimer bk_scheduledTimerWithTimeInterval:0.05f block:^(NSTimer *timer) {
        
        GMSProjection *projection = [_mapView projection];
        CLLocationCoordinate2D fl = projection.visibleRegion.farLeft;
        CLLocationCoordinate2D fr = projection.visibleRegion.farRight;
        CLLocation *left = [[CLLocation alloc] initWithLatitude:fl.latitude longitude:fl.longitude];
        CLLocation *right = [[CLLocation alloc] initWithLatitude:fr.latitude longitude:fr.longitude];
        
        // distance
        CLLocationDistance screenM = [left distanceFromLocation:right];
        
        // distance per pixel
        CGFloat screenPX = CGRectGetWidth(_mapView.bounds);
        CGFloat scalePXmax = screenPX * self.viewToScaleRatio;
        
        CGFloat mPerPX = screenM / screenPX;
        CGFloat scalePXsize = mPerPX * scalePXmax;
        
        if (self.scaleUnit == CHGMapViewScaleUnitMiles) {
            
            scalePXsize = scalePXsize * 0.000621371f;
            
            _scaleText = @{ @0.25 : @"1/4 mile", @0.5 : @"1/2 mile", @0.75 : @"3/4 mile",
                            @1 : @"1 mile", @2 : @"2 miles", @5 : @"5 miles",
                            @10 : @"10 miles", @20 : @"20 miles", @50 : @"50 miles",
                            @100 : @"100 miles", @200 : @"200 miles", @500 : @"500 miles",
                            @1000 : @"1000 miles", @2000 : @"2000 miles", @5000 : @"5000 miles",
                            @10000 : @"10000 miles", @20000 : @"20000 miles", @50000 : @"50000 miles",
                            @100000 : @"100000 miles", @200000 : @"200000 miles", @500000 : @"500000 miles",};
        } else {
            _scaleText = @{ @10 : @"10m", @20 : @"20m", @50 : @"50m",
                            @100 : @"100m", @200 : @"200m", @500 : @"500m",
                            @1000 : @"1km", @2000 : @"2km", @5000 : @"5km",
                            @10000 : @"10km", @20000 : @"20km", @50000 : @"50km",
                            @100000 : @"100km", @200000 : @"200km", @500000 : @"500km",
                            @1000000 : @"1000km", @2000000 : @"2000km", @5000000 : @"5000km",
                            @10000000 : @"10000km", @20000000 : @"20000km", @50000000 : @"50000km" };
        }
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"floatValue" ascending:YES];
        NSArray *sortedKeys = [[_scaleText allKeys] sortedArrayUsingDescriptors:@[sortDescriptor]];
        NSString *scaleLabel = @"";
        
        for (NSNumber *key in sortedKeys) {
            if (key.floatValue / scalePXsize > 1.f) {
                scalePXsize = scalePXmax * key.floatValue / scalePXsize;
                scaleLabel = [_scaleText objectForKey:key];
                break;
            }
        }
        
        _scale.frame = CGRectMake(0, 0, scalePXsize, 1);
        _scale.backgroundColor = self.scaleColor;
        _scale.center = CGPointMake(_mapView.center.x, 30);
        
        _scaleLabel.frame = CGRectMake(0, 0, scalePXsize, 11);
        _scaleLabel.textColor = self.scaleTextColor;
        _scaleLabel.textAlignment = self.scaleTextAlignement;
        _scaleLabel.center = CGPointMake(_mapView.center.x, 36);
        _scaleLabel.text = scaleLabel;
        
    } repeats:FALSE];
}

@end
