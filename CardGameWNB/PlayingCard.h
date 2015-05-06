//
//  PlayingCard.h
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/15.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
