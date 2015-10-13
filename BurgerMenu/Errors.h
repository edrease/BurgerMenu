//
//  Errors.h
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/16/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kStackOverFlowErrorDomain;

typedef enum : NSUInteger {
  StackOverFlowBadParameter,
  StackOverFlowNoAccessToken,
  StackOverFlowBadToken,
  StackOverFlowAccessDenied,
  StackOverFlowMethodDoesNotExist,
  StackOverFlowNoKeyPassed,
  StackOverFlowTokenCompromised,
  StackOverFlowWriteFailed,
  StackOverFlowDuplicateRequest,
  StackOverFlowInternalError,
  StackOverFlowThrottleViolation,
  StackOverFlowTemporarilyUnavailable
  
} StackOverFlowErrorCodes;
