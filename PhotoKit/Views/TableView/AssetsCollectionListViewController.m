//
//  AssetsCollectionListViewController.m
//  PhotoKit
//
//  Created by Varun Rathi on 14/12/18.
//  Copyright © 2018 Varun Rathi. All rights reserved.
//

#import "AssetsCollectionListViewController.h"

@interface AssetsCollectionListViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation AssetsCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    // Do any additional setup after loading the view.
}

-(void)setUpViews {
    
    
}

#pragma mark - Table View methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
