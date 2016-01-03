//
//  CHGMapView.m
//  Pods
//
//  Created by Christian on 03.01.16.
//
//

#import "CHGMapView.h"

#import "NSObject+BKBlockObservation.h"

@implementation CHGMapView

+ (instancetype)mapWithFrame:(CGRect)frame camera:(GMSCameraPosition *)camera
{
    CHGMapView *mapView = [super mapWithFrame:frame camera:camera];
    
    mapView.scale = [[CHGMapViewScale alloc] initWithMapView:mapView];
    [mapView.scale setHidden:YES];
    
    return mapView;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"camera"];
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
    [self bk_removeAllBlockObservers];
}

- (void)showScale
{
    [self showScaleWithAutomaticUpdates:NO];
}

- (void)showScaleWithAutomaticUpdates:(BOOL)autoUpdates
{
    if (autoUpdates) {
        [self bk_addObserverForKeyPath:@"camera" task:^(id target) {
            [self updateScale];
        }];
    }
    
    [self.scale setHidden:NO];
    [self.scale update];
}

@end
