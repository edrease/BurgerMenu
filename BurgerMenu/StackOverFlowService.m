//
//  StackOverFlowService.m
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/17/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import "StackOverFlowService.h"
#import <AFNetworking/AFNetworking.h>
#import "QuestionJSONParser.h"
#import "Errors.h"
#import "Question.h"

@implementation StackOverFlowService

+ (void) questionsForSearchTerm: (NSString *)searchTerm completionHandler:(void(^)(NSArray *, NSError *))completionHandler {
  
  NSString *url = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=%@&site=stackoverflow",searchTerm];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * __nonnull operation, id __nonnull responseObject) {
    NSLog(@"%ld", operation.response.statusCode);
    NSLog(@"%@", responseObject);
    
    NSArray *questions = [QuestionJSONParser questionsResults:responseObject];
    completionHandler(questions,nil);
    
  } failure:^(AFHTTPRequestOperation * __nonnull operation, NSError * __nonnull error) {
    if (operation.response) {
      NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
      dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(nil, stackOverflowError);
      });
    } else {
      NSError *reachabilityError = [self checkReachability];
      if (reachabilityError) {
        completionHandler(nil, reachabilityError);
      }
    }
  }];
}

+(NSError *)checkReachability {
  if (![AFNetworkReachabilityManager sharedManager].reachable) {
    NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:StackOverFlowTemporarilyUnavailable userInfo:@{NSLocalizedDescriptionKey: @"Could not connect to server"}];
    return error;
  }
  return nil;
}

+ (NSError *)errorForStatusCode: (NSInteger) statusCode {
  
  NSInteger errorCode;
  NSString *localizedDescription;
  
  switch (statusCode) {
    case 400:
      localizedDescription = @"Sorry! Bad parameter!";
      errorCode = StackOverFlowBadParameter;
      break;
      
    case 401:
      localizedDescription = @"Access token required";
      errorCode = StackOverFlowNoAccessToken;
      break;
      
    case 402:
      localizedDescription = @"Invalid access";
      errorCode = StackOverFlowBadToken;
      break;
      
    case 403:
      localizedDescription = @"Access denied";
      errorCode = StackOverFlowAccessDenied;
      break;
      
    case 404:
      localizedDescription = @"That doesn't exist!";
      errorCode = StackOverFlowMethodDoesNotExist;
      break;
      
    case 405:
      localizedDescription = @"You don't have the key!";
      errorCode = StackOverFlowNoKeyPassed;
      break;
      
    case 406:
      localizedDescription = @"Login no longer secure";
      errorCode = StackOverFlowTokenCompromised;
      break;
      
    case 407:
      localizedDescription = @"Failed to write";
      errorCode = StackOverFlowWriteFailed;
      break;
      
    case 409:
      localizedDescription = @"You already requested that!";
      errorCode = StackOverFlowDuplicateRequest;
      break;
      
    case 500:
      localizedDescription = @"Unexpected error occurred";
      errorCode = StackOverFlowInternalError;
      break;
      
    case 502:
      localizedDescription = @"You have reached your rate limit";
      errorCode = StackOverFlowThrottleViolation;
      break;
      
    case 503:
      localizedDescription = @"Temporarily unavailable";
      errorCode = StackOverFlowTemporarilyUnavailable;
      break;
      
    default:
      break;
    }
      NSError *error = [NSError errorWithDomain:kStackOverFlowErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey: localizedDescription}];
      
      return error;
  }
  



@end
