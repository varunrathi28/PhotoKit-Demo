//
//  CollectionTableCell.m
//  PhotoKit
//
//  Created by Varun Rathi on 14/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "CollectionTableCell.h"

@implementation CollectionTableCell

+(NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)prepareForReuse {
    [super prepareForReuse];
    _imgViewThumbnail.image = nil;
    _lblCount.text = @"0";
    _lblName.text = nil;
}

@end
