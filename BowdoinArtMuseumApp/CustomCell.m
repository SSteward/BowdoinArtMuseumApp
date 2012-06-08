//
//  CustomCell.m
//  ArtMuseumApp
//
//  Created by Samuel Steward on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize primaryLabel;
@synthesize secondaryLabel;
@synthesize thumbnail;

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGFloat cellHeight = contentRect.size.height;
    CGRect frame;
    
    frame= CGRectMake(boundsX+10 ,0, cellHeight, cellHeight);
    thumbnail.frame = frame;
    
    frame= CGRectMake(boundsX+120 ,2, 200, 25);
    primaryLabel.frame = frame;
    
    frame= CGRectMake(boundsX+120 ,27, 170, cellHeight - 27);
    secondaryLabel.frame = frame;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat cellHeight = self.frame.size.height;
        
        primaryLabel = [[UILabel alloc]init];
        primaryLabel.textAlignment = UITextAlignmentLeft;
        primaryLabel.font = [UIFont systemFontOfSize:16*cellHeight/44];
        
        secondaryLabel = [[UILabel alloc]init];
        secondaryLabel.textAlignment = UITextAlignmentLeft;
        secondaryLabel.font = [UIFont systemFontOfSize:13*cellHeight/44];
        secondaryLabel.numberOfLines = 0;
        
        thumbnail = [[UIImageView alloc]init];
        
        [self.contentView addSubview:primaryLabel];
        [self.contentView addSubview:secondaryLabel];
        [self.contentView addSubview:thumbnail];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
