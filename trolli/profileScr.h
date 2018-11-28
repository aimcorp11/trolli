//
//  profileScr.h
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface profileScr : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    IBOutlet UIView *proTopView,*proBottomBar;
    IBOutlet UIButton *proShopBtn,*proScanBtn;
    IBOutlet UIView *profileHolderView;
    IBOutlet UIView *userPicHolder;
    IBOutlet UIView *tableHeader;
    IBOutlet UITableView *proTbl;
    IBOutlet UILabel *uNameLbl,*uNameInitials;
    IBOutlet UILabel *pCartCount;
    IBOutlet UIButton *pCartBtn;
}
@property(nonatomic)IBOutlet UIButton *pCartBtn;
@property(nonatomic)IBOutlet UILabel *pCartCount;
@property(nonatomic)IBOutlet UILabel *uNameLbl,*uNameInitials;
@property(nonatomic)IBOutlet UIView *userPicHolder;
@property(nonatomic)IBOutlet UIView *tableHeader;
@property(nonatomic)IBOutlet UITableView *proTbl;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property(nonatomic)IBOutlet UIView *profileHolderView;
@property(nonatomic)IBOutlet UIView *proTopView,*proBottomBar;
@property(nonatomic)IBOutlet UIButton *proShopBtn,*proScanBtn;
@end
