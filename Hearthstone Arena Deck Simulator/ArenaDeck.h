//
//  ArenaDeck.h
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface ArenaDeck : UIViewController<UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (void) addCard:(Card *)card;
- (void) deleteCard:(Card *)card;
- (NSMutableArray *) listCard;


@end
 