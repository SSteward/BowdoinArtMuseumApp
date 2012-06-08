//
//  IntroductionViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataStorageObject.h"

@interface IntroductionViewController : UIViewController{
    
    AVAudioPlayer *introductionPlayer;
    AVAudioPlayer *historyPlayer;
    
    DataStorageObject *universalData;
    
    IBOutlet UIImageView *imageDisplay;
}

@property (nonatomic, retain) AVAudioPlayer *introductionPlayer;
@property (nonatomic, retain) AVAudioPlayer *historyPlayer;

@property (nonatomic, retain) DataStorageObject *universalData;


- (IBAction)introductionPressed;
- (IBAction)historyPressed;

@end
