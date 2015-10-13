//
//  ViewController.m
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/15/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "ContainerViewController.h"
#import "QuestionSearchViewController.h"
#import "MainMenuTableViewController.h"
#import "MyQuestionsViewController.h"
#import "WebViewController.h"

CGFloat const kBurgerScreenOpenScreenDivider = 3.0;
NSTimeInterval const kTimeToSlideMenuOpen = 0.4;
CGFloat const kBurgerOpenScreenMultiplier = 2.0;
CGFloat const kBurgerButtonWidth = 50.0;
CGFloat const kBurgerButtonHeight = 50.0;

@interface ViewController () <UITableViewDelegate>

@property (strong, nonatomic) UIViewController *topController;
@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

//Adding Main Menu VC (burger menu)
  MainMenuTableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
  mainMenuVC.tableView.delegate = self;
  
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  
//Adding Question Search VC
  QuestionSearchViewController *questionSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionSearch"];
  
  [self addChildViewController:questionSearchVC];
  questionSearchVC.view.frame = self.view.frame;
  
  [self.view addSubview:questionSearchVC.view];
  [questionSearchVC didMoveToParentViewController:self];
  
  self.topController = questionSearchVC;
  
  
//Burger Button goes here
  UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kBurgerButtonWidth, kBurgerButtonHeight)];
  [burgerButton setImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
  [self.topController.view addSubview:burgerButton];
  [burgerButton addTarget:self action:@selector(burgerButtonPressed:)forControlEvents:UIControlEventTouchUpInside];
  self.burgerButton = burgerButton;
  
//Pan gesture
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topControllerPanned:)];
  [self.topController.view addGestureRecognizer:pan];
  self.pan = pan;
  
}

-(void)viewDidAppear:(BOOL)animated {
  
  
//  WebViewController *webVC = [[WebViewController alloc] init];
//  [self presentViewController:webVC animated:true completion:nil];
}

-(void)topControllerPanned: (UIPanGestureRecognizer *)sender {
  
  CGPoint velocity = [sender velocityInView:self.topController.view];
  CGPoint translation = [sender translationInView:self.topController.view];
  
  if (sender.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0) {
      self.topController.view.center = CGPointMake(self.topController.view.center.x + translation.x, self.topController.view.center.y);
      [sender setTranslation:CGPointZero inView:self.topController.view];
    }
  }
  
  if (sender.state == UIGestureRecognizerStateEnded) {
    if (self.topController.view.frame.origin.x > self.topController.view.frame.size.width / kBurgerScreenOpenScreenDivider) {
      
      [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
        self.topController.view.center = CGPointMake(self.view.center.x * kBurgerOpenScreenMultiplier, self.topController.view.center.y);
      } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.topController.view addGestureRecognizer:tap];
        self.burgerButton.userInteractionEnabled = false;
      
      }];
    } else {
      [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
        self.topController.view.center = CGPointMake(self.view.center.x, self.topController.view.center.y);
      } completion:^(BOOL finished) {
        
      }];
    }
  }
}

-(void)tapToCloseMenu: (UIGestureRecognizer *)tap {
  [self.topController.view removeGestureRecognizer:tap];
  [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
    self.topController.view.center = self.view.center;
  }completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
  }];
}

-(void)burgerButtonPressed: (UIButton *)sender {
  [UIView animateWithDuration:kTimeToSlideMenuOpen animations:^{
    self.topController.view.center = CGPointMake(self.view.center.x * kBurgerOpenScreenMultiplier, self.topController.view.center.y);
  }completion:^(BOOL finished) {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
    [self.topController.view addGestureRecognizer:tap];
    sender.userInteractionEnabled = false;
  }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void)switchToViewController: (UIViewController *)newVC {
  [UIView animateWithDuration:0.4 animations:^{
    self.topController.view.frame = CGRectMake(self.topController.view.frame.origin.x, self.topController.view.frame.origin.x, self.view.frame.size.width, self.view.frame.size.height);
  }completion:^(BOOL finished) {
    CGRect oldFrame = self.topController.view.frame;
    [self.topController willMoveToParentViewController:nil];
    [self.topController.view removeFromSuperview];
    [self.topController removeFromParentViewController];
    
    [self addChildViewController:newVC];
    newVC.view.frame = oldFrame;
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    self.topController = newVC;
    
    [self.burgerButton removeFromSuperview];
    [self.topController.view addSubview:self.burgerButton];
    
    [UIView animateWithDuration:0.4 animations:^{
      self.topController.view.center = self.view.center;
    } completion:^(BOOL finished) {
      [self.topController.view addGestureRecognizer:self.pan];
      self.burgerButton.userInteractionEnabled = true;
    }];
  }];
}

#pragma mark

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  QuestionSearchViewController *questionSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionSearch"];
  MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestions"];
  
  switch (indexPath.row) {
      
    case 0:
      if (![questionSearchVC isEqual:self.topController]) {
        [self switchToViewController:questionSearchVC];
      }
      break;
      
    case 1:
      if (![myQuestionsVC isEqual:self.topController]) {
        [self switchToViewController:myQuestionsVC];
      }
      
      break;
      
    case 2:
      //show my profile vc
      NSLog(@"Fart");
      break;
      
    default:
      break;
  }
}

@end
