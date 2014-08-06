//
//  CardDrawer.m
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import "CardDrawer.h"

@implementation CardDrawer

-(Card *)drawRandomCard:(NSString*)playerClass rarity:(NSString*)rarity{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:@"Card"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    
    if([rarity isEqualToString:@"Common"]){

        request.predicate =
        [NSPredicate predicateWithFormat:@"((playerClass== %@) OR (playerClass==nil)) AND ((rarity==%@) OR (rarity==Free))", playerClass,rarity];
    }else {
        request.predicate =
        [NSPredicate predicateWithFormat:@"((playerClass== %@) OR (playerClass==nil)) AND (rarity==%@)", playerClass,rarity];
    }
    request.predicate =
    [NSPredicate predicateWithFormat:@"((playerClass== %@) OR (playerClass==nil)) AND (rarity==%@)", playerClass,rarity];
    
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array != nil) {
        NSUInteger count = [array count];
         NSLog(@"fetched: %d",count);
        srandom(self.seed);
        self.seed=random();
        return [array objectAtIndex:(random()%count)];
    }
    else {
        // Deal with error.
    }
    
    return nil;
}

@end
