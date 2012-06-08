//
//  IntroductionViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IntroductionViewController.h"

#define SOUND_FILES_LOCAL YES

@implementation IntroductionViewController
@synthesize introductionPlayer;
@synthesize historyPlayer;
@synthesize universalData;

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
    
    //get the sound players for the two audio files
    self.introductionPlayer = [self.universalData getIntroAudioclip:1];
    self.historyPlayer = [self.universalData getIntroAudioclip:2];
    
    //load the image from the model,
    imageDisplay.image = [self.universalData getExhibitImageForIndex:0];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //when the view is no longer being displayed the audio will stop playing
    [self.introductionPlayer pause];
    [self.historyPlayer pause];

}
- (void)viewDidUnload{
    [super viewDidUnload];
        // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//pair of methods run when the corresponding buttons are pressed.  Only allow one sound file to be played at a time, and pressing a second time pauses any playing audio.
- (IBAction)introductionPressed{
    NSLog(@"playing introduction");
    if (!self.introductionPlayer.playing){
        //not playing yet
        [self.historyPlayer pause];
        [self.introductionPlayer play];
    }
    else{
        //already playing
        [self.introductionPlayer pause];
    }
}
- (IBAction)historyPressed{
    NSLog(@"playing history");
    if (!self.historyPlayer.playing){
        //not playing yet
        [self.introductionPlayer pause];
        [self.historyPlayer play];
    }
    else{
        //already playing
        [self.historyPlayer pause];
    }
}

@end
