//
//  AssetsCollectionListViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 14/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "AssetsCollectionListViewController.h"
#import <Photos/Photos.h>
#import "CollectionTableCell.h"

@interface AssetsCollectionListViewController () <UITableViewDelegate, UITableViewDataSource,PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) PHFetchResult * allPhotos;
@property (nonatomic,strong) PHFetchResult * smartAlbums;


@end

@implementation AssetsCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setupData];
    // Do any additional setup after loading the view.
}

-(void)setUpViews {
    [self setUpTableView];
    
}

-(void)setUpTableView {
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 64.0f;
    
}

-(void)dealloc {
    [self unregisterPhotoLibrary];
}

-(void)setupData
{
    PHFetchOptions * allPhotoOptions = [PHFetchOptions new];
    allPhotoOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    _allPhotos = [PHAsset fetchAssetsWithOptions:allPhotoOptions];
    _smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    [self registerPhotoLibrary];
}


-(void)registerPhotoLibrary {
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

-(void)unregisterPhotoLibrary{
    
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}


#pragma mark - Table View methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
           
        case 0:
            return _allPhotos.count;
            break;
            
        case 1:
            return _smartAlbums.count;
       
        default:
            return 1;
            break;
    };
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    CollectionTableCell * cell = [tableView dequeueReusableCellWithIdentifier:[CollectionTableCell reuseIdentifier] forIndexPath:indexPath];
    
    switch (indexPath.section) {

        case 0: {
            PHAsset * asset = _allPhotos[indexPath.row];
            cell.lblName.text = asset.accessibilityLabel;
        }
            
        case 1: {
            PHAssetCollection * assetCollection = [_smartAlbums objectAtIndex:indexPath.row];
            cell.lblName.text = assetCollection.localizedTitle;
            
        }
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Photo library change observer

-(void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}

@end
