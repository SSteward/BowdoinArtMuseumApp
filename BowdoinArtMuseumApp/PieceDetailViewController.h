//
//  PieceDetailViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "DataStorageObject.h"

@interface PieceDetailViewController : UIViewController{
    IBOutlet UIImageView *pieceImageDisplay;
    
    IBOutlet UIScrollView *pieceTextDisplay;
    
    AVAudioPlayer *pieceAudioPlayer;
    
    DataStorageObject *universalData;
    int exhibitNumber;
    NSIndexPath *pieceIndexPath;
    
}

@property (nonatomic, retain) IBOutlet UIImageView *pieceImageDisplay;

@property (nonatomic, retain) IBOutlet UIScrollView *pieceTextDisplay;

@property (nonatomic, retain) AVAudioPlayer *pieceAudioPlayer;

@property (nonatomic, retain) DataStorageObject *universalData;
@property (nonatomic, assign) int exhibitNumber;
@property (nonatomic, retain) NSIndexPath *pieceIndexPath;

@end
