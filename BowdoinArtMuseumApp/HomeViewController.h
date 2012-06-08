//
//  HomeViewController.h
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStorageObject.h"



@interface HomeViewController : UIViewController <UITableViewDelegate, UISearchBarDelegate>{
    DataStorageObject *universalData;
    
    
}
@property (nonatomic, retain) DataStorageObject *universalData;


@end
