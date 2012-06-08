//
//  FloorPlanViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FloorPlanViewController.h"

@implementation FloorPlanViewController
@synthesize mapDisplay;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Floor Plan";
        self.tabBarItem.image = [UIImage imageNamed:@"maps"];
        self.view.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set up of the scrollviewcontroller with the map of the museum
    UIImage *image = [UIImage imageNamed:@"lowerfloor"];
    imageView = [[UIImageView alloc] initWithImage:image];
    self.mapDisplay.contentSize = image.size;
    self.mapDisplay.bounces = NO;
    self.mapDisplay.minimumZoomScale = 0.3;
    self.mapDisplay.maximumZoomScale = 3.0;
    self.mapDisplay.zoomScale = 0.536002;
    self.mapDisplay.delegate = self;
    [self.mapDisplay addSubview:imageView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//switches the floors displayed between the upper and lower floors, and resets the zooming and panning to the starting point
- (IBAction)switchFloors:(UISegmentedControl *)sender{
    while ([self.mapDisplay.subviews count] > 0) {
        //NSLog(@"subviews Count=%d",[[myScrollView subviews]count]);
        [[[self.mapDisplay subviews] objectAtIndex:0] removeFromSuperview];
    }
    if (sender.selectedSegmentIndex == 0){
        //lower floor is selected
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lowerfloor"]];
        self.mapDisplay.zoomScale = 0.536002;
        [self.mapDisplay addSubview:imageView];
    }
    else{
        //ground floor has been selected
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"upperfloor"]];
        self.mapDisplay.zoomScale = 0.536002;
        [self.mapDisplay addSubview:imageView];
    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return imageView;
}

@end
