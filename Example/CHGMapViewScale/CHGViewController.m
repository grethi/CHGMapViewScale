//
//  CHGViewController.m
//  CHGMapViewScale
//
//  Created by Christian on 12/28/2015.
//  Copyright (c) 2015 Christian. All rights reserved.
//

#import "GoogleMaps/GoogleMaps.h"
#import "CHGMapViewScale.h"

#import "CHGViewController.h"

@interface CHGViewController ()

@end

@implementation CHGViewController {
    GMSMapView *mapView_;
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.285
                                                            longitude:103.848
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView_;
    
    CHGMapViewScale *mapViewScale_ = [[CHGMapViewScale alloc] initWithMapView:mapView_];
    [mapViewScale_ update];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
