//
//  DataStorageObject.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface DataStorageObject : NSObject{
    NSMutableDictionary *imageDictionary;
    NSMutableDictionary *soundDictionary;
    NSArray *dataArray;
}
@property (nonatomic, retain) NSMutableDictionary *imageDictionary;
@property (nonatomic, retain) NSMutableDictionary *soundDictionary;
@property (nonatomic, retain) NSArray *dataArray;


- (int) NumberOfExhibitsPlusIntroduction;

//introduction sound file accessors


//exhibit information accessors
- (AVAudioPlayer *)getIntroAudioclip:(int)clipNumber;
- (NSString *)getExhibitNameForIndex:(int)exhibitNumber;
- (NSString *)getExhibitDescriptionForIndex:(int)exhibitNumber;
- (UIImage *)getExhibitImageForIndex:(int)exhibitNumber;
- (AVAudioPlayer *)getExhibitAudioForIndex:(int)exhibitNumber;

- (NSArray *)getSectionsforExhibitIndex:(int)exhibitNumber;
- (int) NumberOfSectionsForExhibitIndex:(int)exhibitNumber;
- (NSArray *)getPiecesInSection:(int)sectionIndex ForExhibitIndex:(int)exhibitNumber;
- (int) NumberOfPiecesInSection:(int)sectionIndex ForExhibitIndex:(int)exhibitNumber;




//Piece information accessors
- (NSString *)getPieceNameForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber;
- (NSString *)getPieceArtistForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber;
- (NSString *)getPieceDescriptionForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber;
- (UIImage *)getPieceImageForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber;
- (AVAudioPlayer *)getPieceAudioForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber;
@end
