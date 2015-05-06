//
//  PlayingCardDeck.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/19.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "PlayingCardDeck.h"

@interface PlayingCardDeck()

@end

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                [card setSuit:suit];
                [card setRank:rank];
                [self addCard:card];
            }
        }
        
    }
    
    return self;
}

@end
