//
//  GTCollectionViewLayout.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/6.
//

#import "GTCollectionViewLayout.h"

@implementation GTCollectionViewLayout

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(300, 400);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        if (indexPath.row == 2) {
            attributes.frame = CGRectMake(5, 15, 30, 80);
        } else {
            attributes.frame = CGRectMake(5, 15, 100, 200);
        }
        return attributes;

}

@end
