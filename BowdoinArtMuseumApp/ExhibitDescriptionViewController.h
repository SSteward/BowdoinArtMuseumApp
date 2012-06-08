//
//  ExhibitDescriptionViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataStorageObject.h"

@interface ExhibitDescriptionViewController : UIViewController{
    DataStorageObject *universalData;
    int exhibitNumber;
    
    IBOutlet UIScrollView *descriptionTextDisplay;
    
    IBOutlet UIImageView *exampleImageDisplay;
    
    AVAudioPlayer *exhibitAudioPlayer;

}

@property (nonatomic, retain) DataStorageObject *universalData;
@property (nonatomic, assign) int exhibitNumber;


@property (nonatomic, retain) IBOutlet UIScrollView *descriptionTextDisplay;

@property (nonatomic, retain) IBOutlet UIImageView *exampleImageDisplay;

@property (nonatomic, retain) AVAudioPlayer *exhibitAudioPlayer;
@end
