//
//  Card+method.m
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import "Card+method.h"

@implementation Card (method)
-(UIImage *)image{
    NSLog(@"ID :%@",self.id);
    NSBundle *mainBundle = [NSBundle mainBundle];
    UIImage * img=[[UIImage alloc] initWithContentsOfFile:
                   [mainBundle pathForResource: self.id ofType: @"png"]];

    return img;
}

- (NSComparisonResult)compare:(Card *)otherObject {
    if([self.cost compare:otherObject.cost]==NSOrderedSame){
        return [self.name compare:otherObject.name];
    }
    return [self.cost compare:otherObject.cost];
}
@end
