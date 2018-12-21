//
//  CollectionTableCell.h
//  PhotoKit
//
//  Created by Varun Rathi on 14/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CollectionTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView * imgViewThumbnail;
@property (nonatomic,weak) IBOutlet UILabel * lblName;
@property (nonatomic,weak) IBOutlet UILabel * lblCount;

+(NSString *) reuseIdentifier;
@end


