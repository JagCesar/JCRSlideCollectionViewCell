//
//  JCRViewController.m
//  JCRSlideCollectionViewCell
//
//  Created by César Manuel Pinto Castillo on 23/03/14.
//  Copyright (c) 2014 JagCesar. All rights reserved.
//

#import "JCRViewController.h"
#import "JCRSlideCollectionViewCell.h"

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
    
    [[self collectionView] registerClass:[JCRSlideCollectionViewCell class]
              forCellWithReuseIdentifier:NSStringFromClass([JCRSlideCollectionViewCell class])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCRSlideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JCRSlideCollectionViewCell class])
                                                                                 forIndexPath:indexPath];
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
