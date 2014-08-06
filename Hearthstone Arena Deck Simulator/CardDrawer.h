//
//  CardDrawer.h
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface CardDrawer : NSObject

-(Card *)drawRandomCard:(NSString*)playerClass rarity:(NSString*)rarity;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) int seed;
@end
