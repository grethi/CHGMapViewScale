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

- (void)awakeFromNib
{
    self.scale = [[CHGMapViewScale alloc] initWithMapView:self];
    [self.scale setHidden:YES];
    
    [super awakeFromNib];
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
