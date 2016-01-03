//
//  CHGMapView.m
//  Pods
//
//  Created by Christian on 03.01.16.
//
//

#import "CHGMapView.h"

@implementation CHGMapView

+ (instancetype)mapWithFrame:(CGRect)frame camera:(GMSCameraPosition *)camera
{
    CHGMapView *mapView = [super mapWithFrame:frame camera:camera];
    
    mapView.scale = [[CHGMapViewScale alloc] initWithMapView:mapView];
    [mapView.scale setHidden:YES];
    
    return mapView;
}

- (BOOL)isScaleHidden
{
    return self.scale.isHidden;
}

- (void)updateScale
{
    [self.scale update];
}

- (void)hideScale
{
    [self.scale setHidden:YES];
}

- (void)showScale
{
    [self.scale setHidden:NO];
    [self.scale update];
}

@end
