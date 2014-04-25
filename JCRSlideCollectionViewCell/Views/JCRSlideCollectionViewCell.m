//
//  JCRSlideCollectionViewCell.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRSlideCollectionViewCell.h"
#import "JCRTapGestureRecognizer.h"
#import <UIKit/UICollectionView.h>

static const CGFloat imageWidth = 22.f;
static const CGFloat imageHeight = 22.f;
static const CGFloat imageBorderMargin = 20.f;

@interface JCRSlideCollectionViewCell () <UIScrollViewDelegate, JCRTapGestureRecognizerDelegate>

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
        [[self leftImageView] setContentMode:UIViewContentModeScaleAspectFit];
        [[self leftImageView] setFrame:CGRectMake(imageBorderMargin,
                                                  CGRectGetHeight(frame)/2-imageHeight/2,
                                                  imageWidth,
                                                  imageHeight)];
        [[self leftImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleRightMargin];
        [[self leftImageView] setAlpha:0.f];
        [[super contentView] addSubview:[self leftImageView]];
        
        [self setRightImageView:[UIImageView new]],
        [[self rightImageView] setContentMode:UIViewContentModeCenter];
        [[self rightImageView] setFrame:CGRectMake(CGRectGetWidth(frame)-imageBorderMargin-imageWidth,
                                                   CGRectGetHeight(frame)/2-imageHeight/2,
                                                   imageWidth,
                                                   imageHeight)];
        [[self rightImageView] setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin];
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
        
        JCRTapGestureRecognizer *tapGesture = [JCRTapGestureRecognizer new];
        [tapGesture setDelegate:self];
        [self addGestureRecognizer:tapGesture];
        
        [[self contentView] setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

#pragma mark - Properties overrides

- (UIView *)contentView {
    return [self draggableContentView];
}

- (void)setLeftImage:(UIImage *)leftImage {
    if (_leftImage != leftImage) {
        _leftImage = leftImage;
        [[self leftImageView] setImage:[self leftImage]];
    }
}

- (void)setRightImage:(UIImage *)rightImage {
    if (_rightImage != rightImage) {
        _rightImage = rightImage;
        [[self rightImageView] setImage:[self rightImage]];
    }
}

#pragma mark - JCRTapGestureRecognizerDelegate

- (void)tapGestureEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self superview] && [[self superview] isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView*)[self superview];
        NSIndexPath *indexPath = [collectionView indexPathForCell:self];
        BOOL shouldSelect = YES;
        if ([[collectionView delegate] respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)]) {
            shouldSelect = [[collectionView delegate] collectionView:collectionView
                                         shouldSelectItemAtIndexPath:indexPath];
        }
        if (shouldSelect) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [collectionView selectItemAtIndexPath:indexPath
                                             animated:YES
                                       scrollPosition:UICollectionViewScrollPositionNone];
                [[collectionView delegate] collectionView:collectionView
                                 didSelectItemAtIndexPath:indexPath];
            });
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat xOffset = [scrollView contentOffset].x;
    CGFloat alpha = fabsf(xOffset)/(imageBorderMargin+imageWidth);
    if (xOffset < 0) {
        // Draggable content view is dragged right
        if (![self leftBlock]) {
            return;
        }
        
        [[self leftImageView] setAlpha:alpha];
        if (alpha >= 1.f) {
            [[self leftImageView] setFrame:CGRectMake(fabsf(xOffset)-imageWidth,
                                                      CGRectGetHeight([[self contentView] bounds])/2-imageHeight/2,
                                                      imageWidth,
                                                      imageHeight)];
        } else {
            [[self leftImageView] setFrame:CGRectMake(imageBorderMargin,
                                                      CGRectGetHeight([[self contentView] bounds])/2-imageHeight/2,
                                                      imageWidth,
                                                      imageHeight)];
        }
    } else if (xOffset > 0) {
        // Draggable content view is dragged left
        if (![self rightBlock]) {
            return;
        }
        [[self rightImageView] setAlpha:alpha];
        if (alpha >= 1.f) {
            [[self rightImageView] setFrame:CGRectMake(CGRectGetWidth([[self contentView] bounds])-xOffset,
                                                       CGRectGetHeight([[self contentView] bounds])/2-imageHeight/2,
                                                       imageWidth,
                                                       imageHeight)];
        } else {
            [[self rightImageView] setFrame:CGRectMake(CGRectGetWidth([[self contentView] bounds])-imageBorderMargin-imageWidth,
                                                       CGRectGetHeight([[self contentView] bounds])/2-imageHeight/2,
                                                       imageWidth,
                                                       imageHeight)];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate {
    CGFloat xOffset = [scrollView contentOffset].x;
    CGFloat alpha = fabsf(xOffset)/(imageBorderMargin+imageWidth);
    if (xOffset < 0) {
        // Draggable content view was dragged right
        if (alpha >= 1.f && [self leftBlock]) {
            self.leftBlock();
        }
    } else if (xOffset > 0) {
        // Draggable content view is dragged left
        if (alpha >= 1.f && [self rightBlock]) {
            self.rightBlock();
        }
    }
}

@end
