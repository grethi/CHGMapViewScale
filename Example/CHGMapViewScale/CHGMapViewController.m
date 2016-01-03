//
//  CHGMapViewController.m
//  CHGMapViewScale
//
//  Created by Christian on 03.01.16.
//  Copyright © 2016 Christian. All rights reserved.
//

#import "CHGMapViewController.h"

#import "UIBarButtonItem+BlocksKit.h"

@implementation CHGMapViewController {
    CHGMapView *_mapView;
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.285
                                                            longitude:103.848
                                                                 zoom:12];
    _mapView = [CHGMapView mapWithFrame:CGRectZero camera:camera];
    self.view = _mapView;
    
    _mapView.delegate = self;
    
    _mapView.scale.scalePosition = CHGMapViewScalePositionTopRight;
    _mapView.scale.topAdjustment = CGRectGetHeight(self.navigationController.navigationBar.bounds) + 30.f;
    
    [_mapView showScale];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"CHGMapView";
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *milesButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"Miles" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        _mapView.scale.scaleUnit = CHGMapViewScaleUnitMiles;
        [_mapView updateScale];
        
    }];
    
    UIBarButtonItem *kiloButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"Kilometers" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        _mapView.scale.scaleUnit = CHGMapViewScaleUnitKilometers;
        [_mapView updateScale];
        
    }];
    
    self.toolbarItems = @[flex, milesButton, flex, kiloButton, flex];
    [self.navigationController setToolbarHidden:NO];
    
    UIBarButtonItem *showHideButton = [[UIBarButtonItem alloc] bk_initWithTitle:@"Hide" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        if ([_mapView isScaleHidden]) {
            [_mapView showScale];
            [((UIBarButtonItem *)sender) setTitle:@"Hide"];
        } else {
            [_mapView hideScale];
            [((UIBarButtonItem *)sender) setTitle:@"Show"];
        }
    }];
    
    self.navigationItem.rightBarButtonItem = showHideButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    [_mapView updateScale];
}

@end
