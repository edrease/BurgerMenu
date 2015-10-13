//
//  Question.h
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 10/12/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) NSString *authorName;

@end
