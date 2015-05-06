//
//  Card.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/15.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end
