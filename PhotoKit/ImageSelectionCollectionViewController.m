//
//  ImageSelectionCollectionViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "ImageSelectionCollectionViewController.h"

@interface ImageSelectionCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ImageSelectionCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Collection View methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _assets.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * collectionViewCell = [UICollectionViewCell new];
    return collectionViewCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


-(void)showAlertControllerFrom:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable ) (void))completion  {

    UIAlertController * actionsheet = [UIAlertController new];
    
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:nil];
    
    [actionsheet addAction:photoAction];
    [actionsheet addAction:cameraAction];
    
    [self presentViewController:actionsheet animated:YES completion:completion];
    
}

@end
