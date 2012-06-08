//
//  FloorPlanViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloorPlanViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIScrollView *mapDisplay;
    UIImageView *imageView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *mapDisplay;

- (IBAction)switchFloors:(id)sender;

@end
