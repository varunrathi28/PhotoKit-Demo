//
//  ImageSelectionCollectionViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "ImageSelectionCollectionViewController.h"
#import "PhotoCollectionCell.h"

@interface ImageSelectionCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, PHPhotoLibraryChangeObserver> {
    
    CGSize thumbnailSize;
}

@property (nonatomic,strong) PHCachingImageManager * imageManager;


@end

@implementation ImageSelectionCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    // Do any additional setup after loading the view.
}


-(void)setUp {
    
    PHFetchOptions * fetchOptions = [PHFetchOptions new];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate " ascending:YES]];
    _fetchResult = [PHAsset fetchAssetsWithOptions:fetchOptions];

    _imageManager = [[PHCachingImageManager alloc]init];
   // _fetchResult = [PHFetchResult new];
    _assetCollection = [PHAssetCollection new];
    
}

-(void)dealloc {
    
}

-(void)registerPhotosLibrary {
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
}

-(void)deregisterPhotosLibrary {
    
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}

#pragma mark - Collection View methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _fetchResult.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset * asset = [_fetchResult objectAtIndex:indexPath.item];
    PhotoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCollectionCell reuseIdentifier] forIndexPath:indexPath];
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    [_imageManager requestImageForAsset:asset targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
            if (result) {
                cell.thumbNailImage = result;
            }
        }
    }];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}




#pragma mark - Photo Library Change observer

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}

@end
