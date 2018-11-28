//
//  scancodeScr.h
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface scancodeScr : UIViewController<ZBarReaderDelegate,UIAlertViewDelegate>{
    IBOutlet UIView *scanTopView,*scanBottomBar;
    IBOutlet UIView *scanBarView;
    IBOutlet UIButton *scShoppingBtn,*scProfileBtn;
    IBOutlet UILabel *scanLbl;
    IBOutlet UIView *loaderScreen;
    IBOutlet UILabel *scCartCount;
    IBOutlet UIActivityIndicatorView *scannerIndicator;
    IBOutlet UIButton *scCartBtn;
}
@property(nonatomic)IBOutlet UIButton *scCartBtn;
@property(nonatomic)IBOutlet UILabel *scCartCount;
@property(nonatomic)IBOutlet UIActivityIndicatorView *scannerIndicator;
@property(nonatomic)IBOutlet UIView *loaderScreen;
@property(nonatomic)IBOutlet UILabel *scanLbl;
@property(nonatomic)IBOutlet UIButton *scShoppingBtn,*scProfileBtn;
@property(nonatomic)IBOutlet UIView *scanBarView;
@property(nonatomic)IBOutlet UIView *scanTopView,*scanBottomBar;
@end
