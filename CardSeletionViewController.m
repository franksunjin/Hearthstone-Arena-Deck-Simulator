//
//  CardSeletionViewController.m
//  Hearthstone Arena Deck Simulator
//
//  Created by frank on 8/5/14.
//  Copyright (c) 2014 frank. All rights reserved.
//

#import "CardSeletionViewController.h"
#import "CardDrawer.h"
#import "Card+method.h"
#import "ArenaDeck.h"

@interface CardSeletionViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *roundCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardToBeChoose;
@property (strong,nonatomic) Card *card1;
@property (strong,nonatomic) Card *card2;
@property (strong,nonatomic) Card *card3;
@property (strong,nonatomic) CardDrawer *drawer;
@property (strong,nonatomic) ArenaDeck *deck;
@property (nonatomic) int round;
@property (nonatomic) BOOL seeded;
@end

@implementation CardSeletionViewController


- (IBAction)cardSeleted:(UIButton *)sender {
    if(self.round==30){
        return;
    }
    int n=[self.cardToBeChoose indexOfObject:sender];
    if(n==0){
        [self.deck addCard:self.card1];
    }else if(n==1){
        [self.deck addCard:self.card2];
    }else if(n==2){
        [self.deck addCard:self.card3];
    }
    self.round++;
    if(self.round==30){
        [self updateUI];
        return;
    }
    [self drawThreeCard];
    [self updateUI];
}

-(void)setClassTitle:(NSString *)classTitle{
    _classTitle=classTitle;
    self.navigationItem.title=classTitle;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource=self.deck;
    
    self.round=0;
    self.seeded=NO;
    srandom([[NSDate date] timeIntervalSince1970]);
    [self drawThreeCard];
    [self updateUI];
    
    
    
    // Do any additional setup after loading the view.
}
-(CardDrawer*)drawer{
    if(_drawer!=nil)return _drawer;
    _drawer=[[CardDrawer alloc]init];
    _drawer.managedObjectContext=self.managedObjectContext;
    _drawer.seed=[[NSDate date] timeIntervalSince1970];
    return _drawer;

}

-(ArenaDeck*)deck{
    if(_deck!=nil)return _deck;
    _deck=[[ArenaDeck alloc]init];
    //_deck.tableView=self.tableView;
    return _deck;
}
- (void)drawThreeCard{
    float randomFloat=(float)random()/RAND_MAX;
    float rareChance=0.1414;
    NSString *rarity;
    if(self.round==0|self.round==9|self.round==19|self.round==29){
        if(randomFloat<rareChance*rareChance){
            rarity=@"Legendary";
        }
        else if(randomFloat<rareChance){
            rarity=@"Epic";
        }
        else rarity=@"Rare";
    }else{
        if(randomFloat<rareChance*rareChance*rareChance){
            rarity=@"Legendary";
        }
        else if(randomFloat<rareChance*rareChance){
            rarity=@"Epic";
        }
        else if(randomFloat<rareChance){
            rarity=@"Rare";
        }
        else rarity=@"Common";
    }
    self.card1=[self.drawer drawRandomCard:self.classTitle rarity:rarity];
    while (true){
        self.card2=[self.drawer drawRandomCard:self.classTitle rarity:rarity];
        if(self.card1.id!=self.card2.id)break;
    }
    while (true){
        self.card3=[self.drawer drawRandomCard:self.classTitle rarity:rarity];
        if(self.card1.id!=self.card3.id && self.card2.id!=self.card3.id )break;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)updateUI{
    [self.roundCount setTitle:[NSString stringWithFormat:@"%d / 30",self.round]];
    [[self.cardToBeChoose objectAtIndex:0] setBackgroundImage:[self.card1 image] forState:UIControlStateNormal];
    [[self.cardToBeChoose objectAtIndex:1] setBackgroundImage:[self.card2 image] forState:UIControlStateNormal];
    [[self.cardToBeChoose objectAtIndex:2] setBackgroundImage:[self.card3 image] forState:UIControlStateNormal];
    
    [self.tableView reloadData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
