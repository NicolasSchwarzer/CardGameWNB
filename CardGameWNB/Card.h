//
//  Card.h
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/15.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
