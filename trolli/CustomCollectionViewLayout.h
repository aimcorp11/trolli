//
//  CustomCollectionViewLayout.h
//  trolli
//
//  Created by apple on 20/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, strong) NSMutableDictionary *cellLayouts;
@property (nonatomic, assign) CGSize              unitSize;
-(id)initWithSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
