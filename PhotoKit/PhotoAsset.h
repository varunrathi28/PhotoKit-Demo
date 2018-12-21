//
//  AssetModel.h
//  PhotoKit
//
//  Created by Varun Rathi on 20/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoAsset : NSObject

@property (nonatomic,retain) NSString * assetIdentifier;
@property (nonatomic,strong) UIImage * thumbnail;
@property (nonatomic, assign) BOOL downloaded;
@property (nonatomic,assign) CGSize size;
@end


