//
//  CHGMapView.h
//  Pods
//
//  Created by Christian on 03.01.16.
//
//

#import <GoogleMaps/GoogleMaps.h>

#import "CHGMapViewScale.h"

@interface CHGMapView : GMSMapView

@property CHGMapViewScale *scale;

- (void)updateScale;
- (BOOL)isScaleHidden;
- (void)hideScale;
- (void)showScale;

@end
