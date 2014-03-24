# JCRSlideCollectionViewCell

I've seen many apps that have cells that can be swiped sideways to do certain actions. Our designer had an idea that included this, but after some googling I didn't find any proper code that helped me out with this. So I decided to implement this myself and opensource it.

Instead of using UITableViewCell I decided to use UICollectionViewCell. This because I've stopped using UITableView and am always using UICollectionView nowadays.

![Output sample](https://raw.githubusercontent.com/JagCesar/JCRSlideCollectionViewCell/master/demo.gif)

## How do I use it?

Copy JCRSlideCollectionViewCell.h and JCRSlideCollectionViewCell.m to your project, import it and return an instance of this cell in the selector

`- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
`

Check out JCRViewController.m in this view controller to get more information on how it's used.

Hit me back with any ideas!

/C
