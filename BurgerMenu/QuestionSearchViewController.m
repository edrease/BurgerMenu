//
//  QuestionSearchViewController.m
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/15/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "QuestionSearchViewController.h"
#import "QuestionTableViewCell.h"
#import "StackOverFlowService.h" 
#import "Question.h"


@interface QuestionSearchViewController () <UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *questions;
@end

@implementation QuestionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.searchBar.delegate = self;
    // Do any additional setup after loading the view.
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UISeachBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [StackOverFlowService questionsForSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSError *error) {
    if (error) {
      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error!" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *action = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:true completion:nil];
      }];
      [alertController addAction:action];
      [self presentViewController:alertController animated:true completion:nil];
    } else {
      self.questions = results;
      dispatch_group_t group = dispatch_group_create();
      dispatch_queue_t imageQueue = dispatch_queue_create("com.edsstack.stackoverflow", DISPATCH_QUEUE_CONCURRENT );
      
      for (Question *question in results) {
        dispatch_group_async(group, imageQueue, ^{
          NSString *avatarURL = question.avatarURL;
          NSURL *imageURL = [NSURL URLWithString:avatarURL];
          NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
          UIImage *image = [UIImage imageWithData:imageData];
          question.avatarImage = image;
          NSLog(@"%lu",(unsigned long)results.count);
        });
      }
      dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Images Downloaded!" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cool!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          [alertController dismissViewControllerAnimated:true completion:nil];
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:true completion:nil];
        [self.tableView reloadData];

      });
    }
  }];
  
  [self.searchBar resignFirstResponder];
}



#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.questions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//  cell.tag++;
//  NSInteger tag = cell.tag;
  NSLog(@"yaaaaa %lu", (unsigned long)self.questions.count);
  Question *question = [[Question alloc] init];
  question = self.questions[indexPath.row];
  cell.authorName.text = question.authorName;
  cell.questionTitle.text = question.title;
  cell.profileImage.image = question.avatarImage;
  
  return cell;
}

@end
