//
//  ImageManager.m
//  PhotoKit
//
//  Created by Varun Rathi on 13/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "ImageManager.h"
#import <Photos/Photos.h>

@implementation ImageManager

+(instancetype)defaultManager {
    static ImageManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


-(void)requestImageForAsset:(PHAsset *)asset forSize:(CGSize)targetSize options:(PHImageRequestOptions *)options contentMode:(PHImageContentMode)contentMode  withCompletionHandler:(void (^)(UIImage * ))completion{
    
    __weak typeof(self) weakSelf = self;
    [self requestImageForAsset:asset targetSize:targetSize contentMode:contentMode
                       options:options  resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                           if(result) {
                               completion(result);
                               
                               [weakSelf startCachingImagesForAssets:@[asset] targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options];
                           }
                       }];
}


//(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info)

-(void)downloadImageForAsset:(PHAsset *)asset forSize:(CGSize)targetSize WithProgress:(void (^)(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info))progressHandler completion:(void (^) (UIImage *))completionHandler {
    
    __weak typeof(self) weakSelf = self;
    
    PHImageRequestOptions * options = [self imageRequestOptions];
    [options setProgressHandler:^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
        progressHandler(progress,error,stop,info);
    }];
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
       // [self start]
    
        completionHandler(result);
        [weakSelf startCachingImagesForAssets:@[asset] targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options];
        
        
    }];
    
}

-(PHImageRequestOptions *)imageRequestOptions {
    PHImageRequestOptions * options = [PHImageRequestOptions new];
    options.networkAccessAllowed  = YES;
    options.synchronous = NO;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    return options;
}

-(PHFetchOptions *)fetchOptions {
    
    return [PHFetchOptions new];
}


-(void)fetchMostResentAssetFromCollection:(PHAssetCollection *)collection withSize:(CGSize)targetSize options:(PHImageRequestOptions *)options withCompletionHandler:(void (^)(UIImage *))completion {
    
    if (collection) {
    PHFetchResult * assets = [PHAsset fetchAssetsInAssetCollection:collection options:[self fetchOptions]];
        if (assets.count) {
            PHAsset * mostRecentAsset = assets.lastObject;
            [self requestImageForAsset:mostRecentAsset forSize:targetSize options:options contentMode:PHImageContentModeAspectFill withCompletionHandler:^(UIImage * result) {
                completion(result);
            }];
            
        }
    }
}


@end
