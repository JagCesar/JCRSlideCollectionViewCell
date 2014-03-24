//
//  JCRSlideCollectionViewCell.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRSlideCollectionViewCell.h"

static const CGFloat imageWidth = 22.f;
static const CGFloat imageHeight = 22.f;
static const CGFloat imageBorderMargin = 20.f;

@interface JCRSlideCollectionViewCell () <UIScrollViewDelegate>

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
        [[self leftImageView] setFrame:CGRectMake(imageBorderMargin,
                                                  CGRectGetHeight(frame)/2-imageHeight/2,
                                                  imageWidth,
                                                  imageHeight)];
        [[self leftImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
        [[self leftImageView] setBackgroundColor:[UIColor purpleColor]];
        [[self leftImageView] setAlpha:0.f];
        [[super contentView] addSubview:[self leftImageView]];
        
        [self setRightImageView:[UIImageView new]],
        [[self rightImageView] setContentMode:UIViewContentModeCenter];
        [[self rightImageView] setFrame:CGRectMake(CGRectGetWidth(frame)-imageBorderMargin-imageWidth,
                                                   CGRectGetHeight(frame)/2-imageHeight/2,
                                                   imageWidth,
                                                   imageHeight)];
        [[self rightImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin];
        [[self rightImageView] setBackgroundColor:[UIColor purpleColor]];
        [[self rightImageView] setAlpha:0.f];
        [[super contentView] addSubview:[self rightImageView]];
        
        [self setScrollView:[UIScrollView new]];
        [[self scrollView] setAlwaysBounceHorizontal:YES];
        [[self scrollView] setFrame:[[super contentView] bounds]];
        [[self scrollView] setDelegate:self];
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

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xOffset = [scrollView contentOffset].x;
    if (xOffset < 0) {
        // Draggable content view is dragged right
        xOffset = fabsf(xOffset);
        [[self leftImageView] setAlpha:xOffset/(imageBorderMargin+imageWidth)];
    } else if (xOffset > 0) {
        // Draggable content view is dragged left
        [[self rightImageView] setAlpha:xOffset/(imageBorderMargin+imageWidth)];
    }
}

@end
