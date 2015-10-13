//
//  QuestionJSONParser.m
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 10/12/15.
//  Copyright © 2015 cf. All rights reserved.
//

#import "QuestionJSONParser.h"
#import "Question.h"
@implementation QuestionJSONParser

+(NSArray *)questionsResults:(NSDictionary *)jsonInfo {
  
  NSMutableArray *questions = [[NSMutableArray alloc] init];
  
  NSArray *items = jsonInfo[@"items"];
  for (NSDictionary *item in items) {
    Question *question = [[Question alloc] init];
    question.title = item[@"title"];
    NSDictionary *owner = item[@"owner"];
    question.authorName = owner[@"display_name"];
    question.avatarURL = owner[@"profile_image"];
    [questions addObject:question];
  }
  return questions;
  
}

@end
