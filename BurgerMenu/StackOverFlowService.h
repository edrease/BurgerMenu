//
//  StackOverFlowService.h
//  BurgerMenu
//
//  Created by Edrease Peshtaz on 9/17/15.
//  Copyright (c) 2015 cf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverFlowService : NSObject
+ (void) questionsForSearchTerm: (NSString *)searchTerm completionHandler:(void(^)(NSArray *, NSError *))completionHandler;
@end
