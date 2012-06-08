//
//  ExhibitPieceTableViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStorageObject.h"


@interface ExhibitPieceTableViewController : UITableViewController{
    
    DataStorageObject *universalData;
    int exhibitNumber;
    
    

}

@property (nonatomic, retain) DataStorageObject *universalData;
@property (nonatomic, assign) int exhibitNumber;


@end
