//
//  Deck.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/15.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation Deck

- (NSMutableArray *)cards // Getter method, lazy instantiate
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
//        randomCard = [self.cards objectAtIndex:index]; //The same mean to the sentence above
        [self.cards removeObjectAtIndex:index];
    }

    return randomCard;
}

@end
