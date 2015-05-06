//
//  PlayingCard.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/15.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "PlayingCard.h"

@interface PlayingCard()

@end

@implementation PlayingCard

@synthesize suit = _suit; // because we provide setter & getter

+ (NSArray *)validSuits // utility method, get valid suits
{
    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}

- (void)setSuit:(NSString *)suit // setter of suit, make sure suit only has four kind of values
{
    if ([[PlayingCard validSuits] containsObject:suit]) {//[self.suitStrings containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit // getter of suit, if suit is nil, return question mark, otherwise, return suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings // utility method, provide rank strings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank // utility method, get max rank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (NSString *)contents // Overwrite getter of contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setRank:(NSUInteger)rank // setter of rank, make sure rank is valid
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    switch ([otherCards count]) {
        case 1: // match two cards
            if ([self.suit isEqualToString:[otherCards[0] suit]]) {
                score = 1;
            }
            else if (self.rank == [otherCards[0] rank]) {
                score = 4;
            }
            break;
            
        case 2: // match three cards
            if ([self.suit isEqualToString:[otherCards[0] suit]] &&
                [self.suit isEqualToString:[otherCards[1] suit]]) {
                score = 1;
            }
            else if (self.rank == [otherCards[0] rank] &&
                     self.rank == [otherCards[1] rank]) {
                score = 6;
            }
            break;
            
        default:
            break;
    }
    
    return score;
}

@end
