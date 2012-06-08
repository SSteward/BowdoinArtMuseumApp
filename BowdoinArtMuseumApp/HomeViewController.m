//
//  HomeViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomCell.h"
#import "IntroductionViewController.h"
#import "ExhibitDescriptionViewController.h"
#import "ExhibitPieceTableViewController.h"




@implementation HomeViewController
@synthesize universalData;

- (void)dealloc{
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
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

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //preload the image and audio entries for the exhibits in the background.
    dispatch_queue_t downloadQueue = dispatch_queue_create("webAccess", NULL);
    dispatch_async(downloadQueue, ^ {
        for (int y=1; y<[self.universalData NumberOfExhibitsPlusIntroduction]; y++) {
            [self.universalData getExhibitAudioForIndex:y];
            [self.universalData getExhibitImageForIndex:y];
        }
    });
    dispatch_release(downloadQueue);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//makes the first cell larger than the others
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 99;
    }
    return 77;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // only one section needed
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.universalData NumberOfExhibitsPlusIntroduction];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    //populate the cell text
    cell.primaryLabel.text = [self.universalData getExhibitNameForIndex:indexPath.row];
    cell.primaryLabel.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
    cell.secondaryLabel.text = [self.universalData getExhibitDescriptionForIndex:indexPath.row];
    cell.secondaryLabel.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
   
    //populate cell images
    cell.thumbnail.image = [self.universalData getExhibitImageForIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        //pressed the introcuction cell -> make the IntroductionViewController and pass it the model before pushing it
        IntroductionViewController *introDisplay = [[[IntroductionViewController alloc] init] autorelease];
        introDisplay.universalData = self.universalData;
        [self.navigationController pushViewController:introDisplay animated:YES];
    }
    
    else{
        //selected an exhibit cell
        //make the ExhibitDescriptionViewController and ExhibitPieceTableViewController and pass them the model as well as the exhibit identifier number
        
        ExhibitDescriptionViewController *description = [[[ExhibitDescriptionViewController alloc] init] autorelease];
        description.universalData = self.universalData;
        description.exhibitNumber = indexPath.row;
    
        ExhibitPieceTableViewController *pieceList = [[[ExhibitPieceTableViewController alloc] init] autorelease];
        pieceList.universalData = self.universalData;
        pieceList.exhibitNumber = indexPath.row;
        
        //place them in a tabBarController
        UITabBarController *tabBar = [[[UITabBarController alloc] init] autorelease];
        tabBar.viewControllers = [NSArray arrayWithObjects:description,pieceList, nil];
        
        //place the tabBarController in the navigationController
        [self.navigationController pushViewController:tabBar animated:YES];
    }
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}
@end
