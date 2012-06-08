//
//  SplashPageViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SplashPageViewController.h"
#import "HomeViewController.h"
#import "HoursViewController.h"
#import "FloorPlanViewController.h"
#import "ContactViewController.h"
#import "DataStorageObject.h"

@implementation SplashPageViewController
@synthesize universalData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //initilise an instance of the model for the application;
        self.universalData = [[[DataStorageObject alloc] init] autorelease];
        self.view.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
        //self.view.backgroundColor = [UIColor redColor];
        
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
    [loadingImages startAnimating];
    //loads the image needed for the splash page from the model
    imageView.image = [self.universalData getExhibitImageForIndex:0];
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

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //preloads the images needed for the home page 
    for (int x=0; x<[self.universalData NumberOfExhibitsPlusIntroduction]; x++) {
        //attempting to get an image from the model that does not exist will trigger the model to access the image from online and save it
        [self.universalData getExhibitImageForIndex:x];
    }
    
    [self.universalData getIntroAudioclip:1];
    [self.universalData getIntroAudioclip:2];
    
    
    [loadingImages stopAnimating];
    //[self loadRestOfApp];
}

- (IBAction)buttonPressed{
    [self loadRestOfApp];
}

//method that actually makes and pushes the nessesary view controllers for the rest of the app
- (void) loadRestOfApp{
    HomeViewController *viewController1 = [[HomeViewController alloc] init];
    viewController1.universalData = self.universalData;
    HoursViewController *viewController2 = [[HoursViewController alloc] init];
    FloorPlanViewController *viewController3 = [[FloorPlanViewController alloc] init];
    ContactViewController *viewController4 = [[ContactViewController alloc] init];
    
    UITabBarController *tabBarController = [[[UITabBarController alloc] init] autorelease];
    tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2,viewController3,viewController4, nil];
    
    [viewController1 release]; 
    [viewController2 release]; 
    [viewController3 release]; 
    [viewController4 release];
    
    UINavigationController *navCon = [[UINavigationController alloc] init];
    [navCon pushViewController:tabBarController animated:YES];
    
    [self presentModalViewController:navCon animated:YES];
}

@end
