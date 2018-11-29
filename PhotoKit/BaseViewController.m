//
//  BaseViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 22/11/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)requestauthorisationStatus {

}


-(void)showAlertControllerFrom:(UIViewController *)vc animated:(BOOL)animated completion:(void (^ __nullable ) (void))completion  {
    
    UIAlertController * actionsheet = [UIAlertController new];
    UIAlertAction * photoAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:nil];
    [actionsheet addAction:photoAction];
    [actionsheet addAction:cameraAction];
    [self presentViewController:actionsheet animated:YES completion:completion];
    
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
