// Copyright (c) 2017 Christian <greth.christian@googlemail.com>
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
    CHGMapViewScaleUnitKilometres
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
