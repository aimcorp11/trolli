//
//  scanResultScr.h
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface scanResultScr : UIViewController{
    IBOutlet UIView *pagerHolderView;
    IBOutlet UIButton *resultBackBtn;
    IBOutlet UIButton *resultSizeBtn;
    IBOutlet UILabel *resultTitleLbl,*resultCostLbl;
    IBOutlet UIView *resultInfoView,*resultBottomBarV;
    IBOutlet UIButton *resultShopAlertBtn,*resultScannerBtn,*resultProfileBtn;
    IBOutlet UIImageView *resultImg;
    IBOutlet UITextView *resultDescriptionLbl;
    IBOutlet UIButton *hideSizeOptionsBtn;
    IBOutlet UIView *sizeOptionView;
    IBOutlet UIButton *xsBtn,*sBtn,*mBtn,*lBtn,*xlBtn,*xxlBtn;
    IBOutlet UIButton *addToBagBtn;


    IBOutlet UILabel *srCartCount;
    IBOutlet UIButton *srCartBtn;
}
@property(nonatomic)IBOutlet UIButton *srCartBtn;
@property(nonatomic)IBOutlet UILabel *srCartCount;
@property(nonatomic)IBOutlet UIButton *addToBagBtn;
@property(nonatomic)IBOutlet UIButton *hideSizeOptionsBtn;
@property(nonatomic)IBOutlet UIView *sizeOptionView;
@property(nonatomic)IBOutlet UIButton *xsBtn,*sBtn,*mBtn,*lBtn,*xlBtn,*xxlBtn;
@property(nonatomic)IBOutlet UITextView *resultDescriptionLbl;
@property(nonatomic)IBOutlet UIImageView *resultImg;
@property(nonatomic)IBOutlet UIButton *resultShopAlertBtn,*resultScannerBtn,*resultProfileBtn;
@property(nonatomic)IBOutlet UIView *resultInfoView,*resultBottomBarV;
@property(nonatomic)IBOutlet UIView *pagerHolderView;
@property(nonatomic)IBOutlet UIButton *resultBackBtn;
@property(nonatomic)IBOutlet UIButton *resultSizeBtn;
@property(nonatomic)IBOutlet UILabel *resultTitleLbl,*resultCostLbl;
@end

NS_ASSUME_NONNULL_END
