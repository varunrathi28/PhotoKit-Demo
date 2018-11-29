//
//  PhotoCollectionCell.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "PhotoCollectionCell.h"

@implementation PhotoCollectionCell

+(NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

-(void)setThumbNailImage:(UIImage *)thumbNailImage {
    
    self.imageView.image = thumbNailImage;
    
}


-(void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = nil;
    
}

@end
