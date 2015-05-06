//
//  CardMatchingGame.h
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/26.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (strong, nonatomic, readonly) NSString *hint;
@property (nonatomic, readonly) NSUInteger matchingNumber;

- (instancetype)initWithCardCount:(NSUInteger)count withMatchingNumber:(NSUInteger)number usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
