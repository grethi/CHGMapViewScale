// Copyright (c) 2016 Christian <greth.christian@googlemail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        self.topAdjustment = 30.f;
        self.scalePosition = CHGMapViewScalePositionTopCenter;
        self.scaleUnit = CHGMapViewScaleUnitMiles;
        self.scaleColor = [UIColor blackColor];
        self.scaleTextColor = [UIColor blackColor];
        self.scaleTextAlignment = NSTextAlignmentRight;
        
        _scale = [[UIView alloc] init];
        [self addSubview:_scale];
        
        _scaleLabel = [[UILabel alloc] init];
        _scaleLabel.font = [_scaleLabel.font fontWithSize:9.f];
        [self addSubview:_scaleLabel];
        
        [_mapView addSubview:self];
    }
    return self;
}

- (void)update
{
    [updateTimer invalidate];
    
    updateTimer = [NSTimer bk_scheduledTimerWithTimeInterval:0.05f block:^(NSTimer *timer) {
        
        // distance
        CLLocationDistance screenM = [self distance];
        
        // distance per pixel
        CGFloat screenPX = CGRectGetWidth(_mapView.bounds);
        CGFloat scalePXmax = screenPX * self.viewToScaleRatio;
        
        CGFloat mPerPX = screenM / screenPX;
        CGFloat scalePXsize = mPerPX * scalePXmax;
        
        if (self.scaleUnit == CHGMapViewScaleUnitMiles) {
            
            scalePXsize = scalePXsize * 0.000621371f;
            
            _scaleText = @{ @0.0004734 : @"1 ft", @0.000946 : @"5 ft", @0.001893 : @"10 ft",
                            @0.0047348 : @"25 ft", @0.009469 : @"50 ft", @0.018939 : @"100 ft",
                            @0.0473485 : @"250 ft", @0.094697 : @"500 ft", @0.189393 : @"1000 ft",
                            @0.25 : @"1/4 mi", @0.5 : @"1/2 mi", @0.75 : @"3/4 mi",
                            @1 : @"1 mi", @2 : @"2 mi", @5 : @"5 mi",
                            @10 : @"10 mi", @20 : @"20 mi", @50 : @"50 mi",
                            @100 : @"100 mi", @200 : @"200 mi", @500 : @"500 mi",
                            @1000 : @"1000 mi", @2000 : @"2000 mi", @5000 : @"5000 mi",
                            @10000 : @"10000 mi", @20000 : @"20000 mi", @50000 : @"50000 mi",
                            @100000 : @"100000 mi", @200000 : @"200000 mi", @500000 : @"500000 mi",};
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
        
        _scaleLabel.frame = CGRectMake(0, 0, scalePXsize, 11);
        _scaleLabel.textColor = self.scaleTextColor;
        _scaleLabel.textAlignment = self.scaleTextAlignment;
        _scaleLabel.text = scaleLabel;
        
        // position views
        switch (self.scalePosition) {
            case CHGMapViewScalePositionTopLeft:
                _scale.center = CGPointMake(CGRectGetWidth(_scale.frame) / 2 + 5, self.topAdjustment);
                _scaleLabel.center = CGPointMake(CGRectGetWidth(_scaleLabel.frame) / 2 + 5, self.topAdjustment + 6.f);
                break;
            case CHGMapViewScalePositionTopRight:
                _scale.center = CGPointMake(CGRectGetWidth(_mapView.bounds) - CGRectGetWidth(_scale.frame) / 2 - 5 , self.topAdjustment);
                _scaleLabel.center = CGPointMake(CGRectGetWidth(_mapView.bounds) - CGRectGetWidth(_scaleLabel.frame) / 2 - 5, self.topAdjustment + 6.f);
                break;
            default: //CHGMapViewScalePositionTopCenter
                _scale.center = CGPointMake(_mapView.center.x, self.topAdjustment);
                _scaleLabel.center = CGPointMake(_mapView.center.x, self.topAdjustment + 6.f);
                break;
        }
        
    } repeats:NO];
}

- (CLLocationDistance)distance
{
    GMSProjection *projection = [_mapView projection];
    
    CGPoint leftPoint = CGPointMake(0.f, self.topAdjustment);
    CGPoint rightPoint = CGPointMake(CGRectGetWidth(_mapView.bounds), self.topAdjustment);
    
    CLLocationCoordinate2D leftCoord = [projection coordinateForPoint:leftPoint];
    CLLocationCoordinate2D rightCoord = [projection coordinateForPoint:rightPoint];
    
    CLLocation *leftLoc = [[CLLocation alloc] initWithLatitude:leftCoord.latitude longitude:leftCoord.longitude];
    CLLocation *rightLoc = [[CLLocation alloc] initWithLatitude:rightCoord.latitude longitude:rightCoord.longitude];
    
    return [leftLoc distanceFromLocation:rightLoc];
}

@end
