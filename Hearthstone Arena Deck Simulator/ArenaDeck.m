//
//  ArenaDeck.m
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import "ArenaDeck.h"
@interface ArenaDeck()

@property (strong,nonatomic) NSMutableArray *cards;
@property (strong,nonatomic) NSArray *sortedCards;
@end

@implementation ArenaDeck

-(NSMutableArray *)cards{
    if(!_cards)_cards=[[NSMutableArray alloc]init];
    return _cards;
}

- (void) addCard:(Card *)card{
    [self.cards addObject:card];
    self.sortedCards=[self.cards sortedArrayUsingSelector:@selector(compare:)];
}
- (void) deleteCard:(Card *)card{
    [self.cards removeObject:card];
}
- (NSMutableArray *) listCard{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cards count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"card" forIndexPath:indexPath];
    Card *card=self.sortedCards[indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",card.cost];
    
    if([card.rarity isEqualToString:@"Rare"]){
        cell.textLabel.textColor=[UIColor blueColor];
    }else if([card.rarity isEqualToString:@"Epic"]){
        cell.textLabel.textColor=[UIColor purpleColor];
    }
    else if([card.rarity isEqualToString:@"Legendary"]){
        cell.textLabel.textColor=[UIColor orangeColor];
    }else{
         cell.textLabel.textColor=[UIColor blackColor];
    }
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",card.name];
    cell.detailTextLabel.font=[UIFont fontWithName:@"ArialHebrew" size:14];
    //cell.detailTextLabel.font
    return cell;
}

@end
