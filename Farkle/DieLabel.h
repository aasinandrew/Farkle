//
//  DieLabel.h
//  Farkle
//
//  Created by Andrew  Nguyen on 7/23/15.
//  Copyright (c) 2015 Andrew Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DieLabelDelegate;
@interface DieLabel : UILabel
@property (weak, nonatomic) IBOutlet id <DieLabelDelegate> delegate;
@property int value;
@property BOOL isTapped;
@property CGPoint origin;

-(void)roll;
-(void)displayNumber:(int)number;

@end

@protocol DieLabelDelegate <NSObject>
@optional

-(void)dieLabel:(DieLabel *)dieLabel;


@end
