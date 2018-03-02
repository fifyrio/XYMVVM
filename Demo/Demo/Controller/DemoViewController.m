//
//  DemoViewController.m
//  Demo
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "DemoViewController.h"
#import "DemoView.h"
#import "DemoViewModel.h"
#import <Masonry/Masonry.h>

@interface DemoViewController ()

@property (nonatomic, strong) DemoView *mainView;

@property (nonatomic, strong) DemoViewModel *mainViewModel;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Protocol
- (void)xy_addSubviews{
    self.title = @"XYMVVM";
    [self.view addSubview:self.mainView];
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
}

- (void)xy_updateViewConstraints{
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}

- (void)xy_bindViewModel{
}

#pragma mark - Lazy load
- (DemoView *)mainView{
    if (_mainView == nil) {
        _mainView = [[DemoView alloc] initWithViewModel:self.mainViewModel];
    }
    return _mainView;
}

- (DemoViewModel *)mainViewModel{
    if (_mainViewModel == nil) {
        _mainViewModel = [[DemoViewModel alloc] init];
    }
    return _mainViewModel;
}

@end
