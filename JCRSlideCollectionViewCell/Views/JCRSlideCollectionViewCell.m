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

@end

@implementation JCRSlideCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setScrollView:[UIScrollView new]];
        [[self scrollView] setAlwaysBounceHorizontal:YES];
        [[self scrollView] setFrame:[[super contentView] bounds]];
        [[self scrollView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [[self scrollView] setBackgroundColor:[UIColor blueColor]];
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
