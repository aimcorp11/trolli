//
//  loginScr.h
//  trolli
//
//  Created by Himanshu Sharma on 29/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import GoogleSignIn;
@interface loginScr : UIViewController<UITextFieldDelegate,GIDSignInUIDelegate>{
    IBOutlet UITextField *emailAddressTxt,*passwordTxt;
    IBOutlet UIButton *signInBtn,*forgottenPassBtn;
    IBOutlet UIActivityIndicatorView *loginIndicator;
    
    IBOutlet UIButton *loginBackBtn;
    IBOutlet UIView *loginTopView,*loginHolder;
    IBOutlet UIButton *loginFBBtn;
    IBOutlet GIDSignInButton *loginGPlusBtn;
}
@property(nonatomic)IBOutlet GIDSignInButton *loginGPlusBtn;
@property(nonatomic)IBOutlet UIButton *loginFBBtn;
@property(nonatomic)IBOutlet UIButton *loginBackBtn;
@property(nonatomic)IBOutlet UIView *loginTopView,*loginHolder;
@property(nonatomic)IBOutlet UIActivityIndicatorView *loginIndicator;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property(nonatomic)IBOutlet UITextField *emailAddressTxt,*passwordTxt;
@property(nonatomic)IBOutlet UIButton *signInBtn,*forgottenPassBtn;
@end
