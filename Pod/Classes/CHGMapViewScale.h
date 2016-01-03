//
//  FOGMapViewScale.h
//  PinYa
//
//  Created by Christian on 22.12.15.
//  Copyright © 2015 fog. All rights reserved.
//

#import "GoogleMaps/GoogleMaps.h"

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHGMapViewScaleUnit){
    CHGMapViewScaleUnitMiles = 0,
    CHGMapViewScaleUnitKilometers
};

typedef NS_ENUM(NSInteger, CHGMapViewScalePosition){
    CHGMapViewScalePositionTopLeft = 0,
    CHGMapViewScalePositionTopCenter,
    CHGMapViewScalePositionTopRight
};

@interface CHGMapViewScale : UIView

@property float viewToScaleRatio;
@property float topAdjustment;
@property CHGMapViewScalePosition scalePosition;
@property CHGMapViewScaleUnit scaleUnit;
@property UIColor *scaleColor;
@property UIColor *scaleTextColor;
@property NSTextAlignment scaleTextAlignment;

- (instancetype)initWithMapView:(GMSMapView *)mapView;

- (void)update;

@end
