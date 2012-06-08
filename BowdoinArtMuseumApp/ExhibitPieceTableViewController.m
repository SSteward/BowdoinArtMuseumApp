//
//  ExhibitPieceTableViewController.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExhibitPieceTableViewController.h"
#import "PieceDetailViewController.h"
#import "CustomCell.h"

@implementation ExhibitPieceTableViewController
@synthesize universalData;
@synthesize exhibitNumber;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"Pieces";
        self.view.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *sections = [self.universalData getSectionsforExhibitIndex:self.exhibitNumber];
    return [sections objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.universalData getSectionsforExhibitIndex:self.exhibitNumber];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.universalData NumberOfSectionsForExhibitIndex:self.exhibitNumber];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.universalData NumberOfPiecesInSection:section ForExhibitIndex:self.exhibitNumber];
}

- (NSDictionary *) pieceAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *piecesInSection = [self.universalData getPiecesInSection:indexPath.section ForExhibitIndex:self.exhibitNumber];
    return [piecesInSection objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    //place text in the cells
    cell.primaryLabel.text = [self.universalData getPieceNameForPieceIndexPath:indexPath InExhibitIndex:exhibitNumber];
    cell.primaryLabel.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
    
    //cell.primaryLabel.text = [[self pieceAtIndexPath:indexPath]objectForKey:@"name"];
    cell.secondaryLabel.text = [self.universalData getPieceArtistForPieceIndexPath:indexPath InExhibitIndex:exhibitNumber];
    cell.secondaryLabel.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9020 alpha:1.0];
    
    //place images in the cells
    cell.thumbnail.image = [self.universalData getPieceImageForPieceIndexPath:indexPath InExhibitIndex:exhibitNumber];
    
    //attempt to implement and test use of the DSLQueue to preferentially load images on screen right now
    //based on example code -> used to attempt to understand how the DSLQueue works
    /*
    if (cell.thumbnail.image == nil){
        //image not saved, need to access it online and save it
        NSURL *imageURL = [[NSURL alloc] initWithString:[[self pieceAtIndexPath:indexPath]objectForKey:@"imageURL"]];
     
        //use the DSLQueue to preferentially load images that are currently on screen
        DownloadArtImageOperation *newOperation = [[DownloadArtImageOperation alloc] initWithURL:imageURL];
        ExhibitPieceTableViewController *blockSelf = self; 
        DownloadArtImageOperation *blockOperation = newOperation;
        
        [newOperation addCompletionBlock:^(DSLOperation *dslOperation) {
            UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageURL]];
            
            if (image != nil) {
                //save the image
                [self.universalData.imageDictionary setValue:image forKey:[[self pieceAtIndexPath:indexPath]objectForKey:@"imageURL"]];
                
                [blockSelf.tableView reloadRowsAtIndexPaths:[[[NSArray alloc] initWithObjects:indexPath,nil] autorelease] withRowAnimation:UITableViewRowAnimationFade];
            }
            [image autorelease];
        }];
        
        //add the newly made operation to the DSLQueue
        [self.queue addOperation:blockOperation];
        [newOperation release];
    }    
     */
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PieceDetailViewController *pieceDisplay = [[PieceDetailViewController alloc] init];
    pieceDisplay.universalData = self.universalData;
    pieceDisplay.exhibitNumber = self.exhibitNumber;
    pieceDisplay.pieceIndexPath = indexPath;
    
    
    [self.navigationController pushViewController:pieceDisplay animated:YES];
    [pieceDisplay release];
}

@end
