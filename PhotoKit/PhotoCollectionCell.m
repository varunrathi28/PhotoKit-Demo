//
//  PhotoCollectionCell.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "PhotoCollectionCell.h"

#define IMAGE_SELECTED  @"check"

@interface PhotoCollectionCell()
@property (nonatomic, weak) IBOutlet UIImageView * imgAccessory;
@end

@implementation PhotoCollectionCell


-(void)awakeFromNib {
    [super awakeFromNib];
    _imgAccessory.image = [UIImage imageNamed:IMAGE_SELECTED];
    _imgAccessory.hidden = YES;
}

+(NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

-(void)setThumbNailImage:(UIImage *)thumbNailImage {
    self.imageView.image = thumbNailImage;
}

-(void)setCellSelected:(BOOL)selected {
    if (selected) {
        _imgAccessory.hidden = NO;
    }
    else {
        _imgAccessory.hidden = YES;
    }
}




-(void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    
}

@end
