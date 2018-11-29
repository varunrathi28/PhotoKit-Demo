//
//  PhotoCollectionCell.h
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface PhotoCollectionCell : UICollectionViewCell


@property (nonatomic,retain ) NSString * representedAssetIdentifier;
@property (nonatomic,strong) UIImage * thumbNailImage;

@property (nonatomic,weak) IBOutlet UIImageView * imageView;

+(NSString *)reuseIdentifier;
@end


