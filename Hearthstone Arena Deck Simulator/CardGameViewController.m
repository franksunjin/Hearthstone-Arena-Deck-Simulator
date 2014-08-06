//
//  CardGameViewController.m
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardSeletionViewController.h"

@interface CardGameViewController ()

@property (nonatomic) int classCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *classes;

@end

@implementation CardGameViewController

- (IBAction)goToCardSeletion:(UIButton *)sender {
}


-(void)setClassCount:(int)classCount{
    _classCount=classCount;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CardSeletionViewController *svc=(CardSeletionViewController*)segue.destinationViewController;
    svc.classTitle=segue.identifier;
    svc.managedObjectContext=self.managedObjectContext;
    
}

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //NSBundle *mainBundle = [NSBundle mainBundle];
    //UIImage * img=[[UIImage alloc] initWithContentsOfFile:[mainBundle pathForResource: @"CS1_042" ofType: @"png"]];
    //NSLog(@"log: %@",[NSString stringWithFormat:@"%@/cards/CS1_042.png",[self applicationDocumentsDirectory]]);
    //[[self.classes objectAtIndex:0] setBackgroundImage:img forState:UIControlStateNormal];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
