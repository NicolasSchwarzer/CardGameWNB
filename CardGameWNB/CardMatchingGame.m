//
//  CardMatchingGame.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/26.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic, readwrite) NSString *hint;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, readwrite) NSUInteger matchingNumber;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count withMatchingNumber:(NSUInteger)number usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        if (count < 2) {
            self = nil;
            return self;
        }
        
        if (number < 2) {
            self = nil;
            return self;
        }
        
        if (number > count) {
            self = nil;
            return self;
        }
        
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
        }
        
        self.matchingNumber = number;
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int COST_TO_CHOOSE = 1;
static const int MATCH_BOUNS = 4;
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self.cards objectAtIndex:index];
    if (!card.matched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.hint = @"Flip over card\n";
        }
        else { // Match other cards
            self.hint = [NSString stringWithFormat:@"Get point: %d, unfold card\n", -COST_TO_CHOOSE];
            self.score -= COST_TO_CHOOSE;
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (!otherCard.isMatched && otherCard.isChosen) {
                    [otherCards addObject:otherCard]; // Add cards to be matched
                }
            }
            if ([otherCards count] == self.matchingNumber - 1) {
                NSInteger matchScore = [card match:otherCards];
                if (matchScore) {
                    // MATCH_BOUNS * self.matchingNumber is the matching bouns
                    NSInteger gainScore = matchScore * MATCH_BOUNS * self.matchingNumber;
                    self.hint = [self.hint stringByAppendingString:[NSString stringWithFormat:@"Get point: %ld, matched\n", gainScore]];
                    self.score += gainScore;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                    // Check game is completed or not
                    [self checkGameCompleted];
                }
                else {
                    self.hint = [self.hint stringByAppendingString:
                                [NSString stringWithFormat:@"Get point: %ld, mismatched\n", -self.matchingNumber]];
                    self.score -= self.matchingNumber; // Matching penalty
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                }
            }
            card.chosen = YES;
        }
    }
}

- (void)checkGameCompleted
{
    switch (self.matchingNumber) {
        case 2:
            for (int index = 0; index < [self.cards count]; index++) { // of object card
                if ([self.cards[index] isMatched]) {
                    continue;
                }
                for (int indexToMatch = index + 1; indexToMatch < [self.cards count]; indexToMatch++) { // of object card, to match
                    if ([self.cards[indexToMatch] isMatched]) {
                        continue;
                    }
                    if ([self.cards[index] match:@[self.cards[indexToMatch]]]) { // match still exists
                        return;
                    }
                }
            }
            self.hint = [self.hint stringByAppendingString:@"No more matches, completed!!\n"];
            for (Card *card in self.cards) {
                card.chosen = YES;
                card.matched = YES;
            }
            break;
            
        case 3:
            for (int index = 0; index < [self.cards count]; index++) { // of object card
                if ([self.cards[index] isMatched]) {
                    continue;
                }
                for (int indexToMatch1 = index + 1; indexToMatch1 < [self.cards count]; indexToMatch1++) { // of object card, to match
                    if ([self.cards[indexToMatch1] isMatched]) {
                        continue;
                    }
                    for (int indexToMatch2 = indexToMatch1 + 1; indexToMatch2 < [self.cards count]; indexToMatch2++) { // of object card, to match
                        if ([self.cards[indexToMatch2] isMatched]) {
                            continue;
                        }
                        if ([self.cards[index] match:@[self.cards[indexToMatch1], self.cards[indexToMatch2]]]) { // match still exists
                            return;
                        }
                    }
                }
            }
            self.hint = [self.hint stringByAppendingString:@"No more matches, completed!!\n"];
            for (Card *card in self.cards) {
                card.chosen = YES;
                card.matched = YES;
            }
            break;
            
        default:
            break;
    }
}

@end
