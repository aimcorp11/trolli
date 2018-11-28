//
//  forgotPasswordScr.h
//  trolli
//
//  Created by Himanshu Sharma on 31/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface forgotPasswordScr : UIViewController<UITextFieldDelegate>{
    IBOutlet UIButton *recoverBtn;
    IBOutlet UIActivityIndicatorView *recoverIndicator;
    IBOutlet UITextField *recoverEmailTxt;
    
    IBOutlet UIButton *forgottenBackBtn;
    IBOutlet UIView *forgottenTopView,*forgottenHolder;
}
@property(nonatomic)IBOutlet UIButton *forgottenBackBtn;
@property(nonatomic)IBOutlet UIView *forgottenTopView,*forgottenHolder;
@property(nonatomic)IBOutlet UIButton *recoverBtn;
@property(nonatomic)IBOutlet UIActivityIndicatorView *recoverIndicator;
@property(nonatomic)IBOutlet UITextField *recoverEmailTxt;
@end
