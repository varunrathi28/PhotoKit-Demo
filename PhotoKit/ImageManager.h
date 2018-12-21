//
//  ImageManager.h
//  PhotoKit
//
//  Created by Varun Rathi on 13/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>



@interface ImageManager : PHCachingImageManager

+(instancetype)defaultManager;

// For Downloading full image
-(void)downloadImageForAsset:(PHAsset *)asset forSize:(CGSize)targetSize WithProgress:(void (^)(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info))progressHandler completion:(void (^) (UIImage *))completionHandler;

-(PHImageRequestOptions *)imageRequestOptions;

// For Thumbnails
-(void)requestImageForAsset:(PHAsset *)asset forSize:(CGSize)targetSize options:(PHImageRequestOptions *)options contentMode:(PHImageContentMode)contentMode  withCompletionHandler:(void (^)(UIImage * ))completion;

// Helper method for fetch most recent thumbail from collection
-(void)fetchMostResentAssetFromCollection:(PHAssetCollection *)collection withSize:(CGSize)targetSize options:(PHImageRequestOptions *)options withCompletionHandler:(void (^)(UIImage *))completion;

@end


