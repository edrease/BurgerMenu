//
//  QuestionJSONParser.h
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 10/12/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionJSONParser : NSObject
+ (NSArray *)questionsResults:(NSDictionary *)jsonInfo;
@end
