//
//  JCRLabelSlideCollectionViewCell.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRLabelSlideCollectionViewCell.h"

@interface JCRLabelSlideCollectionViewCell ()

@property (nonatomic,readwrite) UILabel *label;

@end

@implementation JCRLabelSlideCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setLabel:[UILabel new]];
        [[self label] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [[self label] setFrame:CGRectInset([[self contentView] bounds], 10.f, 0.f)];
        [[self contentView] addSubview:[self label]];
    }
    return self;
}

@end
