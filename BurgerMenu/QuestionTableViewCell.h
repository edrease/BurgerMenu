//
//  QuestionTableViewCell.h
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 10/12/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *questionTitle;
@property (weak, nonatomic) IBOutlet UILabel *authorName;

@end
