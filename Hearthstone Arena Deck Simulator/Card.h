//
//  Card.h
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * playerClass;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * rarity;

@end
