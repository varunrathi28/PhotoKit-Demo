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
#import "ImageManager.h"
#import "ImageSelectionCollectionViewController.h"

@interface AssetsCollectionListViewController () <UITableViewDelegate, UITableViewDataSource,PHPhotoLibraryChangeObserver>

@property (nonatomic, strong) PHFetchResult * allPhotos;
@property (nonatomic,strong) PHFetchResult * albums;


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
    [self setUpNavigation];
    
}

-(void)setUpTableView {
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 64.0f;
    
}

-(void)dealloc {
    [self unregisterPhotoLibrary];
}

-(void)setUpNavigation {
    
    self.navigationItem.title = @"Albums";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(rightNavigationButtonPressed)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)rightNavigationButtonPressed{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupData
{
    PHFetchOptions * allPhotoOptions = [PHFetchOptions new];
    allPhotoOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
    _allPhotos = [PHAsset fetchAssetsWithOptions:allPhotoOptions];
    _albums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
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
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
            
        case 1:
            return _albums.count;
       
        default:
            return 1;
            break;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGSize size = CGSizeMake(100, 100);
    
    CollectionTableCell * cell = [tableView dequeueReusableCellWithIdentifier:[CollectionTableCell reuseIdentifier] forIndexPath:indexPath];
    
    switch (indexPath.section) {

        case 0: {
            PHAsset * asset = [_allPhotos lastObject];
         //   cell.lblName.text = asset.accessibilityLabel;

            cell.lblName.text = @"All Photos";
            
            PHImageRequestOptions * options = [[ImageManager defaultManager] imageRequestOptions];
            
            [[ImageManager defaultManager] requestImageForAsset:asset forSize:size options:options contentMode:PHImageContentModeAspectFill withCompletionHandler:^(UIImage * result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                     cell.imgViewThumbnail.image = result;
                });
            }];

            cell.lblCount.text =  [NSString stringWithFormat:@"%lu",(unsigned long)_allPhotos.count];
            
        }
            
            break;
            
        case 1: {
            
            
            PHAssetCollection * assetCollection = [_albums objectAtIndex:indexPath.row];
            cell.lblName.text = assetCollection.localizedTitle;
            if (assetCollection.estimatedAssetCount > 0) {
                
                cell.lblCount.text = [NSString stringWithFormat:@"%ld",assetCollection.estimatedAssetCount];
                
                PHImageRequestOptions * imageoptions = [[ImageManager defaultManager] imageRequestOptions];
                
                [[ImageManager defaultManager] fetchMostResentAssetFromCollection:assetCollection withSize:size options:imageoptions withCompletionHandler:^(UIImage * result) {

                    dispatch_async(dispatch_get_main_queue(), ^{
                         cell.imgViewThumbnail.image = result;
                    });
                }];
                
            }else {
                
                cell.imgViewThumbnail.image = nil;
            }
   
        }
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     ImageSelectionCollectionViewController * vc  = [ImageSelectionCollectionViewController loadFromStoryboard];
    
    switch (indexPath.section) {
        case 0:
            
            break;
            
        default:
        {
            
            PHAssetCollection * assetCollection = [_albums objectAtIndex:indexPath.row];
            vc.selectedCollection = assetCollection;
        }
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Photo library change observer

-(void)photoLibraryDidChange:(PHChange *)changeInstance {
    
}

@end
