//
//  JCRTapGestureRecognizer.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 25/04/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRTapGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation JCRTapGestureRecognizer

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if ([[self delegate] respondsToSelector:@selector(tapGestureEnded:withEvent:)]) {
        [[self delegate] tapGestureEnded:touches withEvent:event];
    }
}

@end
