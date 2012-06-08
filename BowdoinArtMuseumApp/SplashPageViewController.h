//
//  SplashPageViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStorageObject.h"

@interface SplashPageViewController : UIViewController {
    DataStorageObject *universalData;
    IBOutlet UIActivityIndicatorView *loadingImages;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, retain) DataStorageObject *universalData;

- (void) loadRestOfApp;

- (IBAction)buttonPressed; 

@end
