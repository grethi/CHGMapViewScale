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

/**
 *  Access this property to customize the scale.
 */
@property CHGMapViewScale *scale;

/**
 *  A boolean indicating the scale visibility.
 */
@property (readonly) BOOL isScaleHidden;

/**
 *  Update the graphical scale view.
 */
- (void)updateScale;

/**
 *  Hide the graphical scale view.
 */
- (void)hideScale;

/**
 *  Show the graphical scale view.
 */
- (void)showScale;

/**
 *  Show the graphical scale view.
 *
 *  @param autoUpdates enables or disables automatic scale updates after map view camera changes.
 */
- (void)showScaleWithAutomaticUpdates:(BOOL)autoUpdates;

@end
