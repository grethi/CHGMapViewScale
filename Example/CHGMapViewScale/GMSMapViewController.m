//
//  CHGViewController.m
//  CHGMapViewScale
//
//  Created by Christian on 12/28/2015.
//  Copyright (c) 2015 Christian. All rights reserved.
//

#import "GMSMapViewController.h"

#import "UIBarButtonItem+BlocksKit.h"

@interface GMSMapViewController ()

@end

@implementation GMSMapViewController {
    GMSMapView *_mapView;
    CHGMapViewScale *_mapViewScale;
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.285
                                                            longitude:103.848
                                                                 zoom:12];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = _mapView;
    
    _mapView.delegate = self;
    
    // create a new scale for a specific GMSMapView
    _mapViewScale = [[CHGMapViewScale alloc] initWithMapView:_mapView];
    // customize the scale
    _mapViewScale.scalePosition = CHGMapViewScalePositionTopRight;
    _mapViewScale.topAdjustment = CGRectGetHeight(self.navigationController.navigationBar.bounds) + 30.f;
    // update the scale
    [_mapViewScale update];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"CHGMapViewScale";
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *milesButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"Miles" style:UIBarButtonItemStylePlain handler:^(id sender) {
       
        // change scale settings and update
        _mapViewScale.scaleUnit = CHGMapViewScaleUnitMiles;
        [_mapViewScale update];
        
    }];
    
    UIBarButtonItem *kiloButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"Kilometers" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        // change scale settings and update
        _mapViewScale.scaleUnit = CHGMapViewScaleUnitKilometers;
        [_mapViewScale update];
        
    }];
    
    self.toolbarItems = @[flex, milesButton, flex, kiloButton, flex];
    [self.navigationController setToolbarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    // update the scale view
    [_mapViewScale update];
}

@end
