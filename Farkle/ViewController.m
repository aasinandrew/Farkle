//
//  ViewController.m
//  Farkle
//
//  Created by Andrew  Nguyen on 7/23/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "ViewController.h"
#import "DieLabel.h"

@interface ViewController () <DieLabelDelegate>
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel2;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel3;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel4;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel5;
@property (weak, nonatomic) IBOutlet DieLabel *dieLabel6;
@property NSMutableArray *dice;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScoreLabel;
@property int score;
@property int playerNumber;
@property int playerOneScore;
@property int playerTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *currentScore;
@property NSArray *allDieLabels;
@property int ones;
@property int twos;
@property int threes;
@property int fours;
@property int fives;
@property int sixes;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property UIDynamicAnimator *dynamicAnimator;
@property (weak, nonatomic) IBOutlet UILabel *gatherDiceLabel;
@property int currentRoundSelectedDice;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UIButton *bankButton;



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGame];
}

#pragma mark - Helper Methods
- (void)setUpGame {

    self.bankButton.enabled = NO;
    self.currentPlayerLabel.text = @"Player 1's Turn";
    self.currentRoundSelectedDice = 0;
    self.rollButton.enabled = NO;
    self.dieLabel.value = 5;
    self.dieLabel.isTapped = NO;
    [self.dieLabel displayNumber:5];
    self.dieLabel.hidden = NO;
    self.dieLabel.origin = self.dieLabel.frame.origin;
    self.dieLabel.userInteractionEnabled = NO;
    self.dieLabel.hasScored = NO;

    self.dieLabel2.value = 4;
    self.dieLabel2.isTapped = NO;
    [self.dieLabel2 displayNumber:4];
    self.dieLabel2.hidden = NO;
    self.dieLabel2.origin = self.dieLabel2.frame.origin;
    self.dieLabel2.userInteractionEnabled = NO;
    self.dieLabel2.hasScored = NO;

    self.dieLabel3.value = 5;
    self.dieLabel3.isTapped = NO;
    [self.dieLabel3 displayNumber:5];
    self.dieLabel3.hidden = NO;
    self.dieLabel3.origin = self.dieLabel3.frame.origin;
    self.dieLabel3.userInteractionEnabled = NO;
    self.dieLabel3.hasScored = NO;

    self.dieLabel4.value = 6;
    self.dieLabel4.isTapped = NO;
    [self.dieLabel4 displayNumber:6];
    self.dieLabel4.hidden = NO;
    self.dieLabel4.origin = self.dieLabel4.frame.origin;
    self.dieLabel4.userInteractionEnabled = NO;
    self.dieLabel4.hasScored = NO;

    self.dieLabel5.value = 2;
    self.dieLabel5.isTapped = NO;
    [self.dieLabel5 displayNumber:2];
    self.dieLabel5.hidden = NO;
    self.dieLabel5.origin = self.dieLabel5.frame.origin;
    self.dieLabel5.userInteractionEnabled = NO;
    self.dieLabel5.hasScored = NO;

    self.dieLabel6.value = 3;
    self.dieLabel6.isTapped = NO;
    [self.dieLabel6 displayNumber:3];
    self.dieLabel6.hidden = NO;
    self.dieLabel6.origin = self.dieLabel6.frame.origin;
    self.dieLabel6.userInteractionEnabled = NO;
    self.dieLabel6.hasScored = NO;



    self.dieLabel.delegate = self;
    self.dieLabel2.delegate = self;
    self.dieLabel3.delegate = self;
    self.dieLabel4.delegate = self;
    self.dieLabel5.delegate = self;
    self.dieLabel6.delegate = self;
    self.dice = [NSMutableArray new];
    self.score = 0;
    self.playerOneScore = 0;
    self.playerTwoScore = 0;
    self.playerNumber = 1;
    self.playerOneScoreLabel.text = @"Player 1 Score: 0";
    self.playerTwoScoreLabel.text = @"Player 2 Score: 0";
    self.currentScore.text = @"Current Round Score: 0";
    self.allDieLabels = [NSArray arrayWithObjects:self.dieLabel,
                         self.dieLabel2,
                         self.dieLabel3,
                         self.dieLabel4,
                         self.dieLabel5,
                         self.dieLabel6, nil];
    self.ones = 0;
    self.twos = 0;
    self.threes = 0;
    self.fours = 0;
    self.fives = 0;
    self.sixes = 0;
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(retrieveDice)];
    [self.gatherDiceLabel setUserInteractionEnabled:YES];
    [self.gatherDiceLabel addGestureRecognizer:tapGesture];
}

-(void)reset{
    self.dieLabel.isTapped = NO;
    self.dieLabel2.isTapped = NO;
    self.dieLabel3.isTapped = NO;
    self.dieLabel4.isTapped = NO;
    self.dieLabel5.isTapped = NO;
    self.dieLabel6.isTapped = NO;
    self.dieLabel.hasScored = NO;
    self.dieLabel2.hasScored = NO;
    self.dieLabel3.hasScored = NO;
    self.dieLabel4.hasScored = NO;
    self.dieLabel5.hasScored = NO;
    self.dieLabel6.hasScored = NO;

    self.rollButton.enabled = NO;
    self.gatherDiceLabel.userInteractionEnabled = YES;
}

-(BOOL)checkHotDice {

    if (self.dieLabel.hasScored &&
        self.dieLabel2.hasScored &&
        self.dieLabel3.hasScored &&
        self.dieLabel4.hasScored &&
        self.dieLabel5.hasScored &&
        self.dieLabel6.hasScored)
        return true;

    return false;
}

-(void)hotDiceRoll {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You have hot dice!" message:@"Roll Again" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        [self.dice removeAllObjects];
        [self reset];
    }];
}

-(void)checkWinner {
    if (self.playerOneScore >= 10000) {
        [self winner:@"Player 1"];
    }
    else if (self.playerTwoScore >= 10000) {
        [self winner:@"Player 2"];
    }
}

-(void)winner:(NSString *)winner {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Winner!" message:[NSString stringWithFormat:@"%@ Won", winner] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Start a New Game" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        [self viewDidLoad];
    }];

}

#pragma mark - Gather/Roll Dice Methods
-(void)rollDice {
    self.gatherDiceLabel.userInteractionEnabled = NO;

    if (self.dieLabel.isTapped) {
        self.dieLabel.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel.userInteractionEnabled = YES;
    }
    if (self.dieLabel2.isTapped) {
        self.dieLabel2.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel2.userInteractionEnabled = YES;
    }
    if (self.dieLabel3.isTapped) {
        self.dieLabel3.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel3.userInteractionEnabled = YES;
    }
    if (self.dieLabel4.isTapped) {
        self.dieLabel4.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel4.userInteractionEnabled = YES;
    }
    if (self.dieLabel5.isTapped) {
        self.dieLabel5.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel5.userInteractionEnabled = YES;
    }
    if (self.dieLabel6.isTapped) {
        self.dieLabel6.userInteractionEnabled = NO;
    }
    else {
        self.dieLabel6.userInteractionEnabled = YES;
    }

    [self.dynamicAnimator removeAllBehaviors];
    UISnapBehavior *snapBehavior;
    CGPoint point;
    point = CGPointMake(self.dieLabel.origin.x + 40, self.dieLabel.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    point = CGPointMake(self.dieLabel2.origin.x + 40, self.dieLabel2.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel2 snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    point = CGPointMake(self.dieLabel3.origin.x + 40, self.dieLabel3.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel3 snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    point = CGPointMake(self.dieLabel4.origin.x + 40, self.dieLabel4.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel4 snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    point = CGPointMake(self.dieLabel5.origin.x + 40, self.dieLabel5.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel5 snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];
    point = CGPointMake(self.dieLabel6.origin.x + 40, self.dieLabel6.origin.y + 40);
    snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel6 snapToPoint:point];
    snapBehavior.damping = 0.1;
    [self.dynamicAnimator addBehavior:snapBehavior];


}

-(void)retrieveDice {
    self.rollButton.enabled = YES;
    [self.dynamicAnimator removeAllBehaviors];
    if (!self.dieLabel.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
    if (!self.dieLabel2.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel2 snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
    if (!self.dieLabel3.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel3 snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
    if (!self.dieLabel4.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel4 snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
    if (!self.dieLabel5.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel5 snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
    if (!self.dieLabel6.isTapped) {
        UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self.dieLabel6 snapToPoint:CGPointMake(self.gatherDiceLabel.center.x + 100, self.gatherDiceLabel.center.y)];
        snapBehavior.damping = 1;
        [self.dynamicAnimator addBehavior:snapBehavior];
    }
}




#pragma mark - DieLabel Delegate Method
-(void)dieLabel:(DieLabel *)dieLabel {

    if (![self.dice containsObject:dieLabel]) {
        self.currentRoundSelectedDice++;
        dieLabel.isTapped = YES;
        [dieLabel displayNumber:dieLabel.value];
        self.gatherDiceLabel.userInteractionEnabled = YES;
        [self.dice addObject:dieLabel];
        switch (dieLabel.value) {
            case 1:
                [self addOneDieScore];
                dieLabel.hasScored = YES;
                break;
            case 2:
                [self addTwoDieScore];
                break;
            case 3:
                [self addThreeDieScore];
                break;
            case 4:
                [self addFourDieScore];
                break;
            case 5:
                [self addFiveDieScore];
                dieLabel.hasScored = YES;
                break;
            case 6:
                [self addSixDieScore];
                break;
            default:
                break;
        }
    }
    else if ([self.dice containsObject:dieLabel]) {
        self.currentRoundSelectedDice--;
        [self.dice removeObject:dieLabel];
        dieLabel.isTapped = NO;
        [dieLabel displayNumber:dieLabel.value];
        if (self.currentRoundSelectedDice == 0) {
            self.gatherDiceLabel.userInteractionEnabled = NO;
        }
        switch (dieLabel.value) {
            case 1:
                [self subOneDieScore];
                dieLabel.hasScored = NO;
                break;
            case 2:
                [self subTwoDieScore];
                break;
            case 3:
                [self subThreeDieScore];
                break;
            case 4:
                [self subFourDieScore];
                break;
            case 5:
                [self subFiveDieScore];
                dieLabel.hasScored = NO;
                break;
            case 6:
                [self subSixDieScore];
                break;
            default:
                break;
        }

    }

    if (self.dice.count == 6) {
        BOOL hotDice = [self checkHotDice];
        if (hotDice) {
            [self hotDiceRoll];
        }
    }

    if (self.currentRoundSelectedDice > 0 && self.score > 0) {
        self.bankButton.enabled = YES;
    }
    else {
        self.bankButton.enabled = NO;
    }
}


#pragma mark - Scoring Methods
-(void)addOneDieScore {
    self.ones++;
    switch (self.ones) {
        case 1:
        case 2:
            self.score += 100;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 3:
            self.score += 800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 4:
            self.score += 1800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 5:
            self.score += 2800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 6:
            self.score += 3800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subOneDieScore {
    self.ones--;
    switch (self.ones) {
        case 0:
        case 1:
            self.score -= 100;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 2:
            self.score -= 800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 3:
            self.score -= 1800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 4:
            self.score -= 2800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 5:
            self.score -= 3800;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)addTwoDieScore {
    self.twos++;
    switch (self.twos) {
        case 1:
        case 2:
            break;
        case 3:
        case 4:
        case 5:
        case 6:
            for (DieLabel *d in self.dice) {
                if (d.value == 2) {
                    d.hasScored = YES;
                }
            }
            self.score += 200;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subTwoDieScore {
    self.twos--;
    switch (self.twos) {
        case 0:
        case 1:
            break;
        case 2:
        case 3:
        case 4:
        case 5:
            for (DieLabel *d in self.dice) {
                if (d.value == 2) {
                    d.hasScored = NO;
                }
            }
            self.score -= 200;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)addThreeDieScore {
    self.threes++;
    switch (self.threes) {
        case 1:
        case 2:
            break;
        case 3:
        case 4:
        case 5:
        case 6:
            for (DieLabel *d in self.dice) {
                if (d.value == 3) {
                    d.hasScored = YES;
                }
            }
            self.score += 300;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subThreeDieScore {
    self.threes--;
    switch (self.threes) {
        case 0:
        case 1:
            break;
        case 2:
        case 3:
        case 4:
        case 5:
            for (DieLabel *d in self.dice) {
                if (d.value == 3) {
                    d.hasScored = NO;
                }
            }
            self.score -= 300;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)addFourDieScore {
    self.fours++;
    switch (self.fours) {
        case 1:
        case 2:
            break;
        case 3:
        case 4:
        case 5:
        case 6:
            for (DieLabel *d in self.dice) {
                if (d.value == 4) {
                    d.hasScored = YES;
                }
            }
            self.score += 400;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subFourDieScore {
    self.fours--;
    switch (self.fours) {
        case 0:
        case 1:
                break;
        case 2:
        case 3:
        case 4:
        case 5:
            for (DieLabel *d in self.dice) {
                if (d.value == 4) {
                    d.hasScored = NO;
                }
            }
            self.score -= 400;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)addFiveDieScore {
    self.fives++;
    switch (self.fives) {
        case 1:
        case 2:
            self.score +=  50;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 3:
            self.score += 400;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 4:
        case 5:
        case 6:
            self.score += 500;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subFiveDieScore {
    self.fives--;
    switch (self.fives) {
        case 0:
        case 1:
            self.score -= 50;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 2:
            self.score -=  400;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        case 3:
        case 4:
        case 5:
            self.score -= 500;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)addSixDieScore {
    self.sixes++;
    switch (self.sixes) {
        case 1:
        case 2:
            break;
        case 3:
        case 4:
        case 5:
        case 6:
            for (DieLabel *d in self.dice) {
                if (d.value == 6) {
                    d.hasScored = YES;
                }
            }
            self.score += 600;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

-(void)subSixDieScore {
    self.sixes--;
    switch (self.sixes) {
        case 0:
        case 1:
                break;
        case 2:
        case 3:
        case 4:
        case 5:
            for (DieLabel *d in self.dice) {
                if (d.value == 6) {
                    d.hasScored = NO;
                }
            }
            self.score -= 600;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}


#pragma mark - Roll/Bank Button Actions
- (IBAction)onBankButtonPressed:(UIButton *)sender {
    self.bankButton.enabled = NO;
    for (DieLabel *d in self.dice) {
        d.userInteractionEnabled = NO;
    }
    if (self.playerNumber == 1) {
        self.playerOneScore += self.score;
        self.score = 0;
        self.playerNumber = 2;
        [self.dice removeAllObjects];
        [self reset];
        self.playerOneScoreLabel.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.playerOneScore];
        self.currentScore.text = @"Current Round Score: 0";
        self.currentPlayerLabel.text = @"Player 2's Turn";
        [self checkWinner];
    }
    else {
        self.playerTwoScore += self.score;
        self.score = 0;
        self.playerNumber = 1;
        [self.dice removeAllObjects];
        [self reset];
        self.playerTwoScoreLabel.text = [NSString stringWithFormat:@"Player 2 Score: %i", self.playerTwoScore];
        self.currentScore.text = @"Current Round Score: 0";
        self.currentPlayerLabel.text = @"Player 1's Turn";
        [self checkWinner];
    }
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {

    [self rollDice];
    if (![self.dice containsObject:self.dieLabel]) {
        [self.dieLabel roll];
    }
    if (![self.dice containsObject:self.dieLabel2]) {
        [self.dieLabel2 roll];
    }
    if (![self.dice containsObject:self.dieLabel3]) {
        [self.dieLabel3 roll];
    }
    if (![self.dice containsObject:self.dieLabel4]) {
        [self.dieLabel4 roll];
    }
    if (![self.dice containsObject:self.dieLabel5]) {
        [self.dieLabel5 roll];
    }
    if (![self.dice containsObject:self.dieLabel6]) {
        [self.dieLabel6 roll];
    }

    BOOL isTriple = [self checkTriple];
    if (!isTriple) {
        [self checkFarkle];
    }
    self.ones = 0;
    self.twos = 0;
    self.threes = 0;
    self.fours = 0;
    self.fives = 0;
    self.sixes = 0;
    self.currentRoundSelectedDice = 0;

    self.rollButton.enabled = NO;
    self.bankButton.enabled = NO;
    
}

#pragma mark - Check Farkle Methods
-(void)farkle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You Farkled" message:@"Your turn is over" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        if (self.playerNumber == 1) {
            self.playerNumber = 2;
            self.score = 0;
            [self.dice removeAllObjects];
            [self reset];
            self.currentScore.text = @"Current Round Score: 0";
            self.currentPlayerLabel.text = @"Player 2's Turn";
        }
        else {
            self.playerNumber = 1;
            self.score = 0;
            [self.dice removeAllObjects];
            [self reset];
            self.currentScore.text = @"Current Round Score: 0";
            self.currentPlayerLabel.text = @"Player 1's Turn";
        }
    }];
}
-(void)checkFarkle {
    if (!self.dieLabel.isTapped &&
        !self.dieLabel2.isTapped &&
        !self.dieLabel3.isTapped &&
        !self.dieLabel4.isTapped &&
        !self.dieLabel5.isTapped &&
        !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped &&
        !self.dieLabel2.isTapped &&
        !self.dieLabel3.isTapped &&
        !self.dieLabel4.isTapped &&
        !self.dieLabel5.isTapped &&
        !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped &&
             self.dieLabel2.isTapped &&
             !self.dieLabel3.isTapped &&
             !self.dieLabel4.isTapped &&
             !self.dieLabel5.isTapped &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if ( self.dieLabel5.value != 1 &&  self.dieLabel5.value != 5 &&
             self.dieLabel6.value != 1 &&  self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if ( self.dieLabel6.value != 1 &&  self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if ( self.dieLabel2.value != 1 &&  self.dieLabel2.value != 5 &&
             self.dieLabel4.value != 1 &&  self.dieLabel4.value != 5 &&
             self.dieLabel5.value != 1 &&  self.dieLabel5.value != 5 &&
             self.dieLabel6.value != 1 &&  self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel6.value != 1 && self.dieLabel6.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel3.value != 1 && self.dieLabel3.value != 5) {
            [self farkle];
        }
    }
    else if (self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel2.value != 1 && self.dieLabel2.value != 5) {
            [self farkle];
        }
    }


    //two
    else if (!self.dieLabel.isTapped   &&
        self.dieLabel2.isTapped   &&
        !self.dieLabel3.isTapped   &&
        !self.dieLabel4.isTapped   &&
        !self.dieLabel5.isTapped   &&
        !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5) {
            [self farkle];
        }
    }



    //three
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5) {
            [self farkle];
        }
    }

    //four
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped  &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5) {
            [self farkle];
        }
    }

    //five
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             !self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel6.value != 1 && self.dieLabel6.value != 5) {
            [self farkle];
        }
    }
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5) {
            [self farkle];
        }
    }

    //six
    else if (!self.dieLabel.isTapped   &&
             !self.dieLabel2.isTapped   &&
             !self.dieLabel3.isTapped   &&
             !self.dieLabel4.isTapped   &&
             !self.dieLabel5.isTapped   &&
             self.dieLabel6.isTapped) {
        if (self.dieLabel.value != 1 && self.dieLabel.value != 5 &&
            self.dieLabel2.value != 1 && self.dieLabel2.value != 5 &&
            self.dieLabel3.value != 1 && self.dieLabel3.value != 5 &&
            self.dieLabel4.value != 1 && self.dieLabel4.value != 5 &&
            self.dieLabel5.value != 1 && self.dieLabel5.value != 5) {
            [self farkle];
        }
    }


}
-(BOOL)checkTriple {
    int oneCount = 0;
    int twoCount = 0;
    int threeCount = 0;
    int fourCount = 0;
    int fiveCount = 0;
    int sixCount = 0;
    for (DieLabel *d in self.allDieLabels) {
        if ([self.dice containsObject:d]) {
            continue;
        }
        else {
            switch (d.value) {
                case 1:
                    oneCount++;
                    break;
                case 2:
                    twoCount++;
                    break;
                case 3:
                    threeCount++;
                    break;
                case 4:
                    fourCount++;
                    break;
                case 5:
                    fiveCount++;
                    break;
                case 6:
                    sixCount++;
                    break;
                default:
                    break;
            }
        }
    }
    if (oneCount >= 3 || twoCount >= 3 || threeCount >= 3 || fourCount >= 3 || fiveCount >= 3 || sixCount >= 3) {
        return true;
    }
    return false;
}


@end
