//
//  CustomCollectionViewLayout.m
//  trolli
//
//  Created by apple on 20/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "CustomCollectionViewLayout.h"

@implementation CustomCollectionViewLayout
int curr;
int yaxis;
-(id)initWithSize:(CGSize)size
{
    curr = 0;
    self = [super init];
    if (self)
    {
        _unitSize = CGSizeMake(size.width/3,size.width/3);
        yaxis = 0;
        _cellLayouts = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)prepareLayout
{

    for (NSInteger i = 0; i < [[self collectionView] numberOfItemsInSection:0]; i ++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGRect frame;

        switch (curr)
        {
            case 0:
                frame = CGRectMake(0, yaxis, _unitSize.width, _unitSize.height);
                curr = curr+1;
                break;
            case 1:
                frame = CGRectMake(_unitSize.width, yaxis, _unitSize.width*2, _unitSize.height*2);
                yaxis = yaxis+_unitSize.height;
                curr = curr+1;
                break;
            case 2:
               frame = CGRectMake(0, yaxis, _unitSize.width, _unitSize.height);
                yaxis = yaxis+_unitSize.height;
                curr = curr+1;
                break;
            case 3:
                frame = CGRectMake(0, yaxis, _unitSize.width*2, _unitSize.height);
                curr = curr+1;
                break;
            case 4:
                frame = CGRectMake(_unitSize.width*2, yaxis, _unitSize.width,
                                   _unitSize.height);
                yaxis = yaxis +_unitSize.height;
                curr = curr+1;
                break;
            case 5:
                frame = CGRectMake(0, yaxis, _unitSize.width, _unitSize.height);
                curr = curr+1;
                break;
            case 6:
                frame = CGRectMake(_unitSize.width, yaxis, _unitSize.width,
                                   _unitSize.height);
                curr = curr+1;
                break;
            case 7:
                frame = CGRectMake(_unitSize.width*2, yaxis, _unitSize.width, _unitSize.height);
                yaxis = yaxis+_unitSize.height;
                curr = 0;
                break;
            default:
                frame = CGRectZero;
                break;
        }
        [attributes setFrame:frame];
        [[self cellLayouts] setObject:attributes forKey:indexPath];
    }
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *retAttributes = [[NSMutableArray alloc] init];
    for (NSIndexPath *anIndexPath in [self cellLayouts])
    {
        UICollectionViewLayoutAttributes *attributes = [self cellLayouts][anIndexPath];
        if (CGRectIntersectsRect(rect, [attributes frame]))
        {
            [retAttributes addObject:attributes];
        }
    }
    return retAttributes;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellLayouts][indexPath];
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(_unitSize.width*3, yaxis);
}
@end
