//
//  PieceDetailViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PieceDetailViewController.h"

@implementation PieceDetailViewController
@synthesize pieceImageDisplay;
@synthesize pieceTextDisplay;
@synthesize pieceAudioPlayer;

@synthesize universalData;
@synthesize exhibitNumber;
@synthesize pieceIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.view.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
    
    //Load the image
    self.pieceImageDisplay.image = [self.universalData getPieceImageForPieceIndexPath:self.pieceIndexPath InExhibitIndex:self.exhibitNumber];
    
    //make as populate with text the UILabel that will be placed in the UIScrollViewController
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.pieceTextDisplay.frame.size.width-5, 1300)] autorelease];
    textLabel.backgroundColor = [UIColor clearColor];
    
    [textLabel setText:[self.universalData getPieceDescriptionForPieceIndexPath:self.pieceIndexPath InExhibitIndex:self.exhibitNumber]];
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    self.pieceTextDisplay.contentSize = textLabel.frame.size;
    self.pieceTextDisplay.showsVerticalScrollIndicator = YES;
    self.pieceTextDisplay.showsHorizontalScrollIndicator = NO;
    [self.pieceTextDisplay addSubview:textLabel];
    
    [self.pieceTextDisplay flashScrollIndicators];
    
    //initilise the sound player for the audio file
    self.pieceAudioPlayer = [self.universalData getPieceAudioForPieceIndexPath:pieceIndexPath InExhibitIndex:exhibitNumber];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.pieceAudioPlayer pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playPressed{
    if (!self.pieceAudioPlayer.playing){
        //not playing yet
        NSLog(@"playing detail");
        [self.pieceAudioPlayer play];
    }
    else{
        [self.pieceAudioPlayer pause];
    }
}

@end
