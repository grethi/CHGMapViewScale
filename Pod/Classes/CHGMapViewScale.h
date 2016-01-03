//
//  FOGMapViewScale.h
//  PinYa
//
//  Created by Christian on 22.12.15.
//  Copyright © 2015 fog. All rights reserved.
//

#import "GoogleMaps/GoogleMaps.h"

#import <UIKit/UIKit.h>

/**
 *  Scale units
 */
typedef NS_ENUM(NSInteger, CHGMapViewScaleUnit) {
    /**
     *  Miles
     */
    CHGMapViewScaleUnitMiles = 0,
    /**
     *  Kilometers
     */
    CHGMapViewScaleUnitKilometers
};

/**
 *  Scale position
 */
typedef NS_ENUM(NSInteger, CHGMapViewScalePosition) {
    /**
     *  Top left
     */
    CHGMapViewScalePositionTopLeft = 0,
    /**
     *  Top center
     */
    CHGMapViewScalePositionTopCenter,
    /**
     *  Top right
     */
    CHGMapViewScalePositionTopRight
};

@interface CHGMapViewScale : UIView

/**
 *  Specify an approximately ratio between the map view and the scale.
 *  This property will define the scale size. DEFAULT: 0.2 -> 20%
 */
@property float viewToScaleRatio;

/**
 *  Space between the top of the map view and scale. DEFAULT: 30px
 */
@property float topAdjustment;

/**
 *  Defines the scale position in its map view. DEFAULT: CHGMapViewScalePositionTopCenter
 */
@property CHGMapViewScalePosition scalePosition;

/**
 *  Defines the unit to use for the scale. DEFAULT: Miles -> CHGMapViewScaleUnitMiles
 */
@property CHGMapViewScaleUnit scaleUnit;

/**
 *  Defines the scale color. DEFAULT: [UIColor blackColor]
 */
@property UIColor *scaleColor;

/**
 *  Defines the text label text color. [UIColor blackColor]
 */
@property UIColor *scaleTextColor;

/**
 *  Defines the text label text alignment. DEFAULT: NSTextAlignmentRight
 */
@property NSTextAlignment scaleTextAlignment;

/**
 *  Create a new scale view and add it on a GMSMapView.
 *
 *  @param mapView The GMSMapView to add the scale.
 *
 *  @return the scale view
 */
- (instancetype)initWithMapView:(GMSMapView *)mapView;

/**
 *  Update the scale.
 */
- (void)update;

@end
