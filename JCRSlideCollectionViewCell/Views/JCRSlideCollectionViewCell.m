//
//  JCRSlideCollectionViewCell.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRSlideCollectionViewCell.h"

@interface JCRSlideCollectionViewCell ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *draggableContentView;
@property (nonatomic) UIImageView *leftImageView;
@property (nonatomic) UIImageView *rightImageView;

@end

@implementation JCRSlideCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setLeftImageView:[UIImageView new]];
        [[self leftImageView] setContentMode:UIViewContentModeCenter];
        [[self leftImageView] setFrame:CGRectMake(20.f, 19.f, 22.f, 22.f)];
        [[self leftImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
        [[self leftImageView] setBackgroundColor:[UIColor purpleColor]];
        [[super contentView] addSubview:[self leftImageView]];
        
        [self setRightImageView:[UIImageView new]],
        [[self rightImageView] setContentMode:UIViewContentModeCenter];
        [[self rightImageView] setFrame:CGRectMake(CGRectGetWidth(frame)-42.f, 19.f, 22.f, 22.f)];
        [[self rightImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin];
        [[self rightImageView] setBackgroundColor:[UIColor purpleColor]];
        [[super contentView] addSubview:[self rightImageView]];
        
        [self setScrollView:[UIScrollView new]];
        [[self scrollView] setAlwaysBounceHorizontal:YES];
        [[self scrollView] setFrame:[[super contentView] bounds]];
        [[self scrollView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [[super contentView] addSubview:[self scrollView]];
        
        [self setDraggableContentView:[UIView new]];
        [[self draggableContentView] setFrame:[[self scrollView] bounds]];
        [[self draggableContentView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [[self scrollView] addSubview:[self draggableContentView]];
        
        [[self contentView] setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

#pragma mark - Properties overrides

- (UIView *)contentView {
    return [self draggableContentView];
}

@end
