//
//  DataStorageObject.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataStorageObject.h"

#define SERVER_ADDRESS @"http://scorpia.bowdoin.edu/artmuseum/app_files/"
#define LOCAL_ACCESS YES


@implementation DataStorageObject
@synthesize imageDictionary;
@synthesize soundDictionary;
@synthesize dataArray;
    

- (id)init{
    self = [super init];
    if (self) {
        // Initilize the structures that will be used to hold data and load the plist
        self.imageDictionary = [[[NSMutableDictionary alloc] init] autorelease];
        self.soundDictionary = [[[NSMutableDictionary alloc] init] autorelease];
        
        NSURL *dataURL;
        if (!LOCAL_ACCESS) {
            NSLog(@"attempted online access");
            dataURL = [[[NSURL alloc] initWithString:[SERVER_ADDRESS stringByAppendingFormat:@"Database.plist"]] autorelease];
        }
        
        self.dataArray = [[[NSArray alloc] initWithContentsOfURL:dataURL] autorelease];
        [dataURL release];
        
        if (self.dataArray == nil) {
            //included to prevent crashing when server is down.
            NSLog(@"got data from bundle");
            //access the plist in the bundle (backup till permenant server established
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Database" ofType:@"plist"];
            self.dataArray = [[[NSArray alloc]initWithContentsOfFile:path] autorelease];
        }
        else
            NSLog(@"got data from online");
    }
    return self;
}

//Methods for internal use by the DataStorageObject to make other code more readable

//Used to access an image stored by the DataStorageObject, or if they are not stored already access them online and save them
- (UIImage *)getImageFor:(NSString *)imageNumber{
    //if image not saved in the imageDictionary it needs to be accessed online and saved
    if ([self.imageDictionary valueForKey:imageNumber] == nil){
        NSURL *imageURL = [[[NSURL alloc] initWithString:[SERVER_ADDRESS stringByAppendingFormat:@"%@%@",@"images/",imageNumber]] autorelease];
        //NSURL *testURL = [[NSURL alloc] initWithString:@"%@%@%@",SERVER_ADDRESS,"images/",imageNumber];
        //NSLog(@"%@%@%@",SERVER_ADDRESS,@"images/",imageNumber);
        
        //NSURL *imageURL = [[[NSURL alloc] initWithString:imageNumber] autorelease];
        NSData *imageData;
        
        if (LOCAL_ACCESS || [imageNumber isEqualToString:@"BowdoinSun.png"]) {
            NSLog(@"local image access");
            NSString *fileName = [imageNumber substringToIndex:[imageNumber length]-4];
            NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"png"];
            imageData = [[NSData alloc] initWithContentsOfFile:path];
        }
        else{
            imageData = [[[NSData alloc] initWithContentsOfURL:imageURL] autorelease];
        }
        
        [self.imageDictionary setValue:[[[UIImage alloc] initWithData:imageData] autorelease] forKey:imageNumber];
    }
    return [self.imageDictionary valueForKey:imageNumber];
}

- (NSDictionary *)getPieceInfoForPieceIndexPath:(NSIndexPath *)indexPath AndExhibitIndex:(int)exhibitNumber{
    NSArray *sectionNames = [self getSectionsforExhibitIndex:exhibitNumber];
    
    NSArray *piecesInSection = [[[self.dataArray objectAtIndex:exhibitNumber] valueForKey:@"Pieces"] objectForKey:[sectionNames objectAtIndex:indexPath.section]];
    return [piecesInSection objectAtIndex:indexPath.row];
}

//Used to access an AVAudioPlayer stored by the DataStorageObject, or if they are not stored already access them online and save them
- (AVAudioPlayer *)getAudioFor:(NSString *)fileName{
    if ([self.soundDictionary valueForKey:fileName] == nil) {
        //access online and save it
        NSURL *fileURL = [NSURL URLWithString:[SERVER_ADDRESS stringByAppendingFormat:@"%@%@",@"audio/",fileName]];
        NSData *fileData;
        if (LOCAL_ACCESS) {
            NSLog(@"local audio access name:%@",fileName);
            NSString *fileString = [fileName substringToIndex:[fileName length]-4];
            NSString *path = [[NSBundle mainBundle] pathForResource:fileString ofType:@"m4a"];
            fileData = [[NSData alloc] initWithContentsOfFile:path];
        }
        else{
            fileData = [[[NSData alloc] initWithContentsOfURL:fileURL] autorelease];
        }
        
        NSError *error;
        AVAudioPlayer *audioPlayer =[[AVAudioPlayer alloc] initWithData:fileData error:&error];
        //AVAudioPlayer *audioPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error] autorelease];
        [self.soundDictionary setValue:audioPlayer forKey:fileName];
    }
    return [self.soundDictionary valueForKey:fileName];
}



- (int) NumberOfExhibitsPlusIntroduction{
    return [self.dataArray count];
}

//exhibit information accessors
- (AVAudioPlayer *)getIntroAudioclip:(int)clipNumber{
    NSString *fileName;
    if (clipNumber ==1) {
        fileName = [[self.dataArray objectAtIndex:0] valueForKey:@"Sound item 1"];
    }
    else{
        fileName = [[self.dataArray objectAtIndex:0] valueForKey:@"Sound item 2"];
    }
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],fileName];
    return [self getAudioFor:fileName];
}



- (NSString *)getExhibitNameForIndex:(int)exhibitNumber{
    NSDictionary *exhibitInfo = [self.dataArray objectAtIndex:exhibitNumber];
    return [exhibitInfo valueForKey:@"Name"];
}

- (NSString *)getExhibitDescriptionForIndex:(int)exhibitNumber{
    NSDictionary *exhibitInfo = [self.dataArray objectAtIndex:exhibitNumber];
    return [exhibitInfo valueForKey:@"Description"];
}

- (UIImage *)getExhibitImageForIndex:(int)exhibitNumber{
    NSString *imageAddress = [[self.dataArray objectAtIndex:exhibitNumber] valueForKey:@"imageURL"];
    return [self getImageFor:imageAddress];
}

- (AVAudioPlayer *)getExhibitAudioForIndex:(int)exhibitNumber{
    NSString *fileName = [[self.dataArray objectAtIndex:exhibitNumber] valueForKey:@"SoundBite"];
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],fileName];
    return [self getAudioFor:fileName];
}


- (NSArray *)getSectionsforExhibitIndex:(int)exhibitNumber{
    NSArray *sections = [[[[self.dataArray objectAtIndex:exhibitNumber] valueForKey:@"Pieces"] allKeys] sortedArrayUsingSelector:@selector(compare:)];
    return sections;
}

- (int) NumberOfSectionsForExhibitIndex:(int)exhibitNumber{
    return [[self getSectionsforExhibitIndex:exhibitNumber] count];
}

- (NSArray *)getPiecesInSection:(int)sectionIndex ForExhibitIndex:(int)exhibitNumber{
    NSDictionary *dictOfPieces = [[self.dataArray objectAtIndex:exhibitNumber] valueForKey:@"Pieces"];
    NSArray *sections = [self getSectionsforExhibitIndex:exhibitNumber];
    return [dictOfPieces objectForKey:[sections objectAtIndex:sectionIndex]];
}

- (int) NumberOfPiecesInSection:(int)sectionIndex ForExhibitIndex:(int)exhibitNumber{
    return [[self getPiecesInSection:sectionIndex ForExhibitIndex:exhibitNumber] count];
}




//Piece information accessors
- (NSString *)getPieceNameForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber{
    NSDictionary *pieceInfo = [self getPieceInfoForPieceIndexPath:indexPath AndExhibitIndex:exhibitNumber];
    return [pieceInfo valueForKey:@"name"];
}

- (NSString *)getPieceArtistForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber{
    NSDictionary *pieceInfo = [self getPieceInfoForPieceIndexPath:indexPath AndExhibitIndex:exhibitNumber];
    return [pieceInfo valueForKey:@"artist"];
}

- (NSString *)getPieceDescriptionForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber{
    NSDictionary *pieceInfo = [self getPieceInfoForPieceIndexPath:indexPath AndExhibitIndex:exhibitNumber];
    return [pieceInfo valueForKey:@"Description"];

}

- (UIImage *)getPieceImageForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber{
    NSDictionary *pieceInfo = [self getPieceInfoForPieceIndexPath:indexPath AndExhibitIndex:exhibitNumber];
    NSString *imageAddress = [pieceInfo valueForKey:@"imageURL"];
    return [self getImageFor:imageAddress]; 

}

- (AVAudioPlayer *)getPieceAudioForPieceIndexPath:(NSIndexPath *)indexPath InExhibitIndex:(int)exhibitNumber{
    NSDictionary *pieceInfo = [self getPieceInfoForPieceIndexPath:indexPath AndExhibitIndex:exhibitNumber];
    NSString *fileName = [pieceInfo valueForKey:@"SoundBite"];
    //NSString *filePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],fileName];
    return [self getAudioFor:fileName];
}


- (void)dealloc{
    [super dealloc];
}

@end
