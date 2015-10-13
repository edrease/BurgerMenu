//
//  MainMenuTableViewController.m
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/15/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "MainMenuTableViewController.h"

@interface MainMenuTableViewController () <UITableViewDataSource, UITableViewDelegate>
@end

@implementation MainMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.dataSource = self;
//  self.tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  NSArray *optionsArray = [NSArray arrayWithObjects:@"Search Questions", @"My Questions", @"My Profile", nil];
  cell.textLabel.text = optionsArray[indexPath.row];
  return cell;
}


#pragma mark UITableViewDelegate

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  switch (indexPath.row) {
//    case 0:
//      //show search questions vc
//      break;
//    case 1:
//      //show my questions vc
//      break;
//    case 2:
//      //show my profile vc
//      break;
//    default:
//      break;
//  }
//}

@end
