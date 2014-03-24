//
//  JCRViewController.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRViewController.h"
#import "JCRLabelSlideCollectionViewCell.h"

@interface JCRViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation JCRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setCollectionViewFlowLayout:[UICollectionViewFlowLayout new]];
    
    [self setCollectionView:[[UICollectionView alloc] initWithFrame:[[self view] bounds]
                                               collectionViewLayout:[self collectionViewFlowLayout]]];
    
    [[self collectionView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [[self collectionView] setDataSource:self];
    [[self collectionView] setDelegate:self];
    [[self view] addSubview:[self collectionView]];
    
    [[self collectionView] registerClass:[JCRLabelSlideCollectionViewCell class]
              forCellWithReuseIdentifier:NSStringFromClass([JCRLabelSlideCollectionViewCell class])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [[self collectionView] performBatchUpdates:^{
        [[self collectionViewFlowLayout] invalidateLayout];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCRLabelSlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JCRLabelSlideCollectionViewCell class])
                                                                                      forIndexPath:indexPath];
    [cell setLeftBlock:^{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Left"
                                                       message:[NSString stringWithFormat:@"Left action on row %ld", [indexPath row]]
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"Ok", nil];
        [view show];
    }];
    
    [cell setRightBlock:^{
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Right"
                                                       message:[NSString stringWithFormat:@"Right action on row %ld", [indexPath row]]
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                             otherButtonTitles:@"Ok", nil];
        [view show];
    }];
    
    [[cell label] setText:[NSString stringWithFormat:@"Row %ld", [indexPath row]]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UI

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth([[self view] bounds]), 60.f);
}

@end
