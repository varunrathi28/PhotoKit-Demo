//
//  ImageSelectionCollectionViewController.h
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface ImageSelectionCollectionViewController : UIViewController
@property (nonatomic,strong) NSMutableArray * albumArray;
@property (nonatomic,strong) PHFetchResult *  fetchResult;
@property (nonatomic,strong) PHAssetCollection * assetCollection;

@property (nonatomic,weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * photoCollectionArray;

@end


