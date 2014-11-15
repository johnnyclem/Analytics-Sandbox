//
//  ViewController.m
//  Analytics Sandbox
//
//  Created by John Clem on 8/14/14.
//  Copyright (c) 2014 Analytics Pros. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "TAGDataLayer.h"
#import "TAGManager.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *screens;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _screens = [[NSMutableArray alloc] initWithObjects:@"Home", @"Search", @"Inbox", @"Profile", nil];
    
    if (!self.title) {
        if (!self.accessibilityLabel) {
            self.title = NSStringFromClass([self class]);
        } else {
            self.title = self.accessibilityLabel;
        }
    }    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
    TAGDataLayer *dataLayer = [[TAGManager instance] dataLayer];
    NSDictionary *event = @{ @"event": @"openScreen", @"screenName": self.title};
    [dataLayer push:event];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _screens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = _screens[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.title = _screens[indexPath.row];
    detailVC.view.backgroundColor = [self randomColor];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
