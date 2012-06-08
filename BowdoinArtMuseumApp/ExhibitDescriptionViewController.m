//
//  ExhibitDescriptionViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExhibitDescriptionViewController.h"

#define SOUND_FILES_LOCAL YES

@implementation ExhibitDescriptionViewController
@synthesize universalData;
@synthesize exhibitNumber;

@synthesize exampleImageDisplay;
@synthesize descriptionTextDisplay;
@synthesize exhibitAudioPlayer;

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
    
    self.title = [NSString stringWithFormat:@"%@ Description",[self.universalData getExhibitNameForIndex:exhibitNumber]];
    
    //load the image from the model
    self.exampleImageDisplay.image = [self.universalData getExhibitImageForIndex:exhibitNumber];
    
    //make as populate with text the UILabel that will be placed in the UIScrollViewController
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.descriptionTextDisplay.frame.size.width-5, 1300)] autorelease];
    [textLabel setText:[self.universalData getExhibitDescriptionForIndex:exhibitNumber]];
    
    textLabel.backgroundColor = [UIColor clearColor];
    
    
    textLabel.numberOfLines = 0;
    [textLabel sizeToFit];
    self.descriptionTextDisplay.contentSize = textLabel.frame.size;
    self.descriptionTextDisplay.showsVerticalScrollIndicator = YES;
    self.descriptionTextDisplay.showsHorizontalScrollIndicator = NO;
    [self.descriptionTextDisplay addSubview:textLabel];
    [self.descriptionTextDisplay flashScrollIndicators];
    
    //initilise the sound player for the audio file
    self.exhibitAudioPlayer = [self.universalData getExhibitAudioForIndex:exhibitNumber];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.exhibitAudioPlayer pause];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playPressed{
    if (!self.exhibitAudioPlayer.playing){
        //not playing yet
        [self.exhibitAudioPlayer play];
    }
    else{
        [self.exhibitAudioPlayer pause];
    }
}

@end
