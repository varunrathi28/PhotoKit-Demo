//
//  ImageSelectionCollectionViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "ImageSelectionCollectionViewController.h"
#import "PhotoCollectionCell.h"

#define width_space 3
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define MAX_ITEM_PER_ROW    4


@interface ImageSelectionCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, PHPhotoLibraryChangeObserver> {
    
    CGSize thumbnailSize;
    UICollectionViewFlowLayout * flowLayout;
}

@property (nonatomic,strong) PHCachingImageManager * imageManager;
@property (nonatomic,strong) NSMutableOrderedSet * selectedAssets;


@end

@implementation ImageSelectionCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedAssets = [NSMutableOrderedSet new];
    _albumArray = [NSMutableArray new];
    _photoCollectionArray = [NSMutableArray new];
    
    [self setUpCollectionViewLayout];
    [self loadData];
    [self getCollectionData:0];
    
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellSize = flowLayout.itemSize;
    thumbnailSize = CGSizeMake(cellSize.width * scale,cellSize.height * scale
                               );
}

-(void)loadData {
    
    
    [self registerPhotosLibrary];
    PHFetchOptions * allPhotosFetchOptions = [PHFetchOptions new];
    allPhotosFetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    _fetchResult = [PHAsset fetchAssetsWithOptions:allPhotosFetchOptions];
    [self addAllPhotosToSource:_fetchResult];
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [self getFetchResultData:smartAlbums];
    
    _imageManager = [[PHCachingImageManager alloc]init];
   // _fetchResult = [PHFetchResult new];
    _assetCollection = [PHAssetCollection new];
    
}

-(void)setUpCollectionViewLayout {
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = width_space;
    layout.minimumInteritemSpacing = width_space;
   CGFloat maxPossibleHeight =  (SCREEN_WIDTH - width_space * (MAX_ITEM_PER_ROW - 1))/MAX_ITEM_PER_ROW;
    layout.itemSize = CGSizeMake(maxPossibleHeight, maxPossibleHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(width_space, 0 , width_space, 0);
    self.collectionView.collectionViewLayout = layout;
    flowLayout = layout;
}


- (void)getCollectionData:(NSInteger)tag {
    
    self.photoCollectionArray = self.albumArray[tag];
    [self.collectionView reloadData];
    [self scrollToBottomWithAnimation:NO];
}


-(void)addAllPhotosToSource:(PHFetchResult *)allPhotos {
    [self.albumArray addObject:allPhotos];
}

-(void)dealloc {
    
    [self deregisterPhotosLibrary];
}

-(void)registerPhotosLibrary {
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
}

-(void)deregisterPhotosLibrary {
    
    [PHPhotoLibrary.sharedPhotoLibrary unregisterChangeObserver:self];
}


-(void)getFetchResultData:(PHFetchResult *)fetchResult{
    
    for (NSInteger i = 0 ; i< fetchResult.count ; i++) {
        
        PHCollection * collection  = fetchResult[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            
            PHAssetCollection * assetCollection = (PHAssetCollection *) collection;
            
            PHFetchResult * assetFetchResult =  [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            
            
            if (assetFetchResult.count != 0) {
                [self.albumArray addObject:assetFetchResult];
            }
        }
        
    }
    
}

#pragma mark - Scroll utility functions

-(void)scrollToIndex:(NSInteger)cellIndex WithAnimated:(BOOL)animated atPosition:(UICollectionViewScrollPosition) position{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0] atScrollPosition:position animated:animated];
}

-(void)scrollToTopWithAnimation:(BOOL)animation {
    
    [self scrollToIndex:0 WithAnimated:NO atPosition:UICollectionViewScrollPositionTop];
}

-(void)scrollToBottomWithAnimation:(BOOL)animation {
    
    [self scrollToIndex:self.photoCollectionArray.count - 1 WithAnimated:NO atPosition:UICollectionViewScrollPositionBottom];
}


#pragma mark - Collection View methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photoCollectionArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset * asset = [_photoCollectionArray objectAtIndex:indexPath.item];
    PhotoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[PhotoCollectionCell reuseIdentifier] forIndexPath:indexPath];
    // Marking cell to identify image when fetching with image manager
    cell.representedAssetIdentifier = asset.localIdentifier;
    
    // Mode should be exact, as it gives perfect image result which can be used on cell.
    PHImageRequestOptions * phImageRequestOptions = [PHImageRequestOptions new];
    phImageRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    
    BOOL isCellAlreadySelected = [self.selectedAssets containsObject:asset];
    [cell setCellSelected:isCellAlreadySelected];
    
    // Request every asset for specified size to be shown as thumbnail
    [_imageManager requestImageForAsset:asset
                             targetSize:thumbnailSize contentMode:PHImageContentModeAspectFill options:phImageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                 
                                 if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                 cell.thumbNailImage = result;
                                 }
                             }];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAsset * selectedAsset = [_photoCollectionArray objectAtIndex:indexPath.row];
    if ([self.selectedAssets containsObject:selectedAsset]) {
        
        [self.selectedAssets removeObject:selectedAsset];
    } else {
        [self.selectedAssets addObject:selectedAsset];
    }
    [collectionView reloadSections: [NSIndexSet indexSetWithIndex:indexPath.section]];
}




#pragma mark - Photo Library Change observer

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}

@end
