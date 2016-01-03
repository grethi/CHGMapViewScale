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
