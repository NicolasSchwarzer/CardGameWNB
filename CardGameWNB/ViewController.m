 //
//  ViewController.m
//  CardGameWNB
//
//  Created by 万宁邦 on 15/4/14.
//  Copyright (c) 2015年 万宁邦. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchingNumberSegment;
@property (weak, nonatomic) IBOutlet UILabel *matchingNumberLabel;

@end

@implementation ViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] withMatchingNumber:self.matchingNumberSegment.selectedSegmentIndex + 2 usingDeck:[self createDeck]];
    }
    return _game;
}

- (Deck *)deck
{
    if (!_deck) {
        _deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger index = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (IBAction)changeMatchingNumberSegment:(UISegmentedControl *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] withMatchingNumber:self.matchingNumberSegment.selectedSegmentIndex + 2 usingDeck:[self createDeck]];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger index = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:index];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backGroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    self.hintLabel.text = self.game.hint;
    self.matchingNumberLabel.text = [NSString stringWithFormat:@"Match %ld Cards", self.game.matchingNumber];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backGroundImageForCard:(Card *)card
{
    return card.isChosen ? [UIImage imageNamed:@"CardFront"] : [UIImage imageNamed:@"CardBack"];
}

@end
