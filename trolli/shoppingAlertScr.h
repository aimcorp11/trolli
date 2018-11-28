//
//  shoppingAlertScr.h
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Firebase;
@interface shoppingAlertScr : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>{
    IBOutlet UIView *saTopView;
    IBOutlet UIView *saBottomBar;
    IBOutlet UIButton *saScanBtn,*saProfileBtn;
    IBOutlet UIButton *saCartBtn;
    IBOutlet UICollectionView *collV;
    
    IBOutlet UIView *buyOverLay;
    IBOutlet UIImageView *buyProductImg;
    IBOutlet UIButton *sizeSmallBtn,*sizeMediumBtn,*sizeLargeBtn,*sizeXLargeBtn;
    IBOutlet UIButton *hideBuyOverlayBtn;
    IBOutlet UILabel *sacartCount;
    
}
@property(nonatomic)IBOutlet UIButton *saCartBtn;
@property(nonatomic)IBOutlet UILabel *sacartCount;
@property(nonatomic)IBOutlet UICollectionView *collV;
@property(nonatomic)IBOutlet UIButton *hideBuyOverlayBtn;
@property(nonatomic)IBOutlet UIView *buyOverLay;
@property(nonatomic)IBOutlet UIImageView *buyProductImg;
@property(nonatomic)IBOutlet UIButton *sizeSmallBtn,*sizeMediumBtn,*sizeLargeBtn,*sizeXLargeBtn;
@property(nonatomic)IBOutlet UIButton *saScanBtn,*saProfileBtn;
@property(nonatomic)IBOutlet UIView *saTopView;
@property(nonatomic)IBOutlet UIView *saBottomBar;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end
