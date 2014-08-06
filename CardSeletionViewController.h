//
//  CardSeletionViewController.h
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardSeletionViewController : UIViewController
@property (nonatomic) NSString * classTitle;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@end
