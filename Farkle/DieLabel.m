//
//  DieLabel.m
//  Farkle
//
//  Created by Andrew  Nguyen on 7/23/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import "DieLabel.h"

@implementation DieLabel

-(void)roll {
    int rand =  (int) arc4random_uniform(6) + 1;
    self.value = rand;
    [self displayNumber:rand];
}

- (id) initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClicked:)];
    [self addGestureRecognizer:tapgesture];
    self.userInteractionEnabled = YES;
    return self;

}

- (void)labelClicked:(UIGestureRecognizer *)g {
    [self.delegate dieLabel:self];
}

-(void)displayNumber:(int)number {
     NSTextAttachment *attachment = [NSTextAttachment new];
    if (self.isTapped) {
        switch (number) {
            case 1:
                attachment.image = [UIImage imageNamed:@"oneblack"];
                break;
            case 2:
                attachment.image = [UIImage imageNamed:@"twoblack"];
                break;
            case 3:
                attachment.image = [UIImage imageNamed:@"threeblack"];
                break;
            case 4:
                attachment.image = [UIImage imageNamed:@"fourblack"];
                break;
            case 5:
                attachment.image = [UIImage imageNamed:@"fiveblack"];
                break;
            case 6:
                attachment.image = [UIImage imageNamed:@"sixblack"];
                break;
            default:
                break;
        }

    }
    else {
        switch (number) {
            case 1:
                attachment.image = [UIImage imageNamed:@"one"];
                break;
            case 2:
                attachment.image = [UIImage imageNamed:@"two"];
                break;
            case 3:
                attachment.image = [UIImage imageNamed:@"three"];
                break;
            case 4:
                attachment.image = [UIImage imageNamed:@"four"];
                break;
            case 5:
                attachment.image = [UIImage imageNamed:@"five"];
                break;
            case 6:
                attachment.image = [UIImage imageNamed:@"six"];
                break;
            default:
                break;
        }

    }

    NSAttributedString *text = [NSAttributedString attributedStringWithAttachment:attachment];
    self.attributedText = text;

}



@end
