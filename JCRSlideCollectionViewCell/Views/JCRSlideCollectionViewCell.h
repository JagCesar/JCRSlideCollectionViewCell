//
//  JCRSlideCollectionViewCell.h
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCRSlideCollectionViewCell : UICollectionViewCell

@property (nonatomic) UIImage *leftImage;
@property (nonatomic) UIImage *rightImage;
@property (nonatomic, copy) void (^leftBlock)(void);
@property (nonatomic, copy) void (^rightBlock)(void);

@end
