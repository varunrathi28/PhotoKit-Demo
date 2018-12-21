//
//  BaseViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "BaseViewController.h"
#import <Photos/Photos.h>
#import "ImageSelectionCollectionViewController.h"
#import "AssetsCollectionListViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestauthorisationStatus];
    // Do any additional setup after loading the view.
}


-(void)requestauthorisationStatus {

    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        switch (status) {
            case PHAuthorizationStatusDenied:
                
                break;
                
            case PHAuthorizationStatusAuthorized :
                break;
                
                
            case PHAuthorizationStatusRestricted:
                break;
                
            case PHAuthorizationStatusNotDetermined:
                break;
                
            default:
                break;
        }
    }];
    
    
}


-(IBAction)btnShowPhotosClicked:(id)sender {
    [self showAlertControllerFrom:self animated:YES completion:nil];
}

-(void)showAlertControllerFrom:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable ) (void))completion  {
    
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertController * actionsheet = [UIAlertController new];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf pushImageSelectionController];
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    
    [actionsheet addAction:photoAction];
    [actionsheet addAction:cameraAction];
    [actionsheet addAction:cancelAction];
    [self presentViewController:actionsheet animated:YES completion:completion];
    
}



-(void)pushImageSelectionController{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
        AssetsCollectionListViewController * vc = [storyBoard instantiateViewControllerWithIdentifier:@"AssetsCollectionListViewController"];
    
  //  ImageSelectionCollectionViewController * vc = [storyBoard instantiateViewControllerWithIdentifier:@"ImageSelectionCollectionViewController"];
    
    
    UINavigationController * navCon = [[UINavigationController alloc]initWithRootViewController:vc];
    
    [self presentViewController:navCon animated:YES completion:nil];
    //[self.navigationController pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
