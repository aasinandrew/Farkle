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


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self reset];


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


}

- (IBAction)onRollButtonPressed:(UIButton *)sender {

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

    self.dieLabel.hidden = NO;
    self.dieLabel2.hidden = NO;
    self.dieLabel3.hidden = NO;
    self.dieLabel4.hidden = NO;
    self.dieLabel5.hidden = NO;
    self.dieLabel6.hidden = NO;
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

    self.rollButton.enabled = NO;

}

-(void)dieLabel:(DieLabel *)dieLabel {
    if (![self.dice containsObject:dieLabel]) {
        self.rollButton.enabled = YES;
        //dieLabel.isTapped = YES;
        [self.dice addObject:dieLabel];

        switch (dieLabel.value) {
            case 1:
                [self addOneDieScore];
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
                break;
            case 6:
                [self addSixDieScore];
                break;
            default:
                break;
        }
    }
}

-(void) reset{
    self.dieLabel.isTapped = NO;
    self.dieLabel2.isTapped = NO;
    self.dieLabel3.isTapped = NO;
    self.dieLabel4.isTapped = NO;
    self.dieLabel5.isTapped = NO;
    self.dieLabel6.isTapped = NO;
    self.dieLabel.hidden = YES;
    self.dieLabel2.hidden = YES;
    self.dieLabel3.hidden = YES;
    self.dieLabel4.hidden = YES;
    self.dieLabel5.hidden = YES;
    self.dieLabel6.hidden = YES;
    self.rollButton.enabled = YES;
}


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
            self.score += 200;
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
            self.score += 300;
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
            self.score += 400;
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
            self.score += 600;
            self.currentScore.text = [NSString stringWithFormat:@"Current Round Score: %i", self.score];
            break;
        default:
            break;
    }
}

- (IBAction)onBankButtonPressed:(UIButton *)sender {
    if (self.playerNumber == 1) {
        self.playerOneScore += self.score;
        self.score = 0;
        self.playerNumber = 2;
        [self.dice removeAllObjects];
        [self reset];
        self.playerOneScoreLabel.text = [NSString stringWithFormat:@"Player 1 Score: %i", self.playerOneScore];
        self.currentScore.text = @"Current Round Score: 0";
    }
    else {
        self.playerTwoScore += self.score;
        self.score = 0;
        self.playerNumber = 1;
        [self.dice removeAllObjects];
        [self reset];
        self.playerTwoScoreLabel.text = [NSString stringWithFormat:@"Player 2 Score: %i", self.playerTwoScore];
        self.currentScore.text = @"Current Round Score: 0";
    }
}

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
        }
        else {
            self.playerNumber = 1;
            self.score = 0;
            [self.dice removeAllObjects];
            [self reset];
            self.currentScore.text = @"Current Round Score: 0";
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
