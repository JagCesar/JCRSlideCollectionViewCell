//
//  JCRTapGestureRecognizer.h
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 25/04/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JCRTapGestureRecognizerDelegate <NSObject>

@optional
- (void)tapGestureEnded:(NSSet*)touches withEvent:(UIEvent *)event;

@end

@interface JCRTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic,assign) id <JCRTapGestureRecognizerDelegate> delegate;

@end
