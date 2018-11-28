//
//  signUpScr.h
//  trolli
//
//  Created by Himanshu Sharma on 31/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import GoogleSignIn;
@interface signUpScr : UIViewController<UITextFieldDelegate,GIDSignInUIDelegate>{
    IBOutlet UITextField *signupEmailTxt,*signupPasswordTxt;
    IBOutlet UIButton *signupBtn,*alreadyAccountBtn;
    IBOutlet UIActivityIndicatorView *signupIndicator;
    IBOutlet UIView *signupTopView,*signupHolder;
    IBOutlet UIButton *signupBackBtn;
    IBOutlet UIButton *showPasswordBtn;
    IBOutlet UIView *maleRadio,*femaleRadio;
    IBOutlet UIButton *maleBtn,*femaleBtn;
    IBOutlet UITextField *birthdayTxt,*birthMonthTxt,*birthYearTxt;
    IBOutlet UITextField *firstNameTxt,*lastNameTxt;
    IBOutlet UIScrollView *masterScroller;
    IBOutlet UIImageView *discountsRadio,*exclusiveOfferRadio;
    IBOutlet UIButton *discountsBtn,*exclusiveOfferBtn;
    IBOutlet UIView *datePickerView;
    IBOutlet UIView *datePickerHolder;
    IBOutlet UIDatePicker *dPicker;
    IBOutlet UIButton *dPickerCancel,*dPickerSelect;
    IBOutlet UIButton *signupFBBtn,*signupGPlusBtn;
    
}
@property(nonatomic)IBOutlet UIButton *signupFBBtn,*signupGPlusBtn;
@property(nonatomic)IBOutlet UIView *datePickerView;
@property(nonatomic)IBOutlet UIView *datePickerHolder;
@property(nonatomic)IBOutlet UIDatePicker *dPicker;
@property(nonatomic)IBOutlet UIButton *dPickerCancel,*dPickerSelect;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property(nonatomic)IBOutlet UITextField *firstNameTxt,*lastNameTxt;
@property(nonatomic)IBOutlet UIImageView *discountsRadio,*exclusiveOfferRadio;
@property(nonatomic)IBOutlet UIButton *discountsBtn,*exclusiveOfferBtn;
@property(nonatomic)IBOutlet UIScrollView *masterScroller;
@property(nonatomic)IBOutlet UIView *maleRadio,*femaleRadio;
@property(nonatomic)IBOutlet UIButton *maleBtn,*femaleBtn;
@property(nonatomic)IBOutlet UITextField *birthdayTxt,*birthMonthTxt,*birthYearTxt;
@property(nonatomic)IBOutlet UIButton *showPasswordBtn;
@property(nonatomic)IBOutlet UIButton *signupBackBtn;
@property(nonatomic)IBOutlet UIView *signupTopView,*signupHolder;
@property(nonatomic)IBOutlet UIActivityIndicatorView *signupIndicator;
@property(nonatomic)IBOutlet UITextField *signupEmailTxt,*signupPasswordTxt;
@property(nonatomic)IBOutlet UIButton *signupBtn,*alreadyAccountBtn;
@end
