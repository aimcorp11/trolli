//
//  signUpScr.m
//  trolli
//
//  Created by Himanshu Sharma on 31/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "signUpScr.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface signUpScr ()

@end

@implementation signUpScr
@synthesize signupBtn,signupEmailTxt,signupPasswordTxt,alreadyAccountBtn;
@synthesize signupIndicator;
@synthesize signupHolder,signupTopView;
@synthesize signupBackBtn;
@synthesize showPasswordBtn;
@synthesize femaleBtn,femaleRadio,maleBtn,maleRadio,birthdayTxt,birthYearTxt,birthMonthTxt;
@synthesize masterScroller;
@synthesize firstNameTxt,lastNameTxt;
@synthesize discountsRadio,discountsBtn,exclusiveOfferRadio,exclusiveOfferBtn;
@synthesize datePickerView,datePickerHolder,dPicker,dPickerCancel,dPickerSelect;
@synthesize signupFBBtn,signupGPlusBtn;
BOOL isFBDone;
- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    self.ref = [[FIRDatabase database] reference];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){

        CGRect frame = datePickerHolder.frame;
        frame.origin.y = datePickerHolder.frame.size.height+20;
        datePickerHolder.frame = frame;
        
        CGRect hframe = masterScroller.frame;
        hframe.origin.y = 30;
        hframe.size.height = self.view.frame.size.height-50;
        masterScroller.frame = hframe;
    }
    
    femaleRadio.layer.cornerRadius = femaleRadio.frame.size.height/2;
    femaleRadio.layer.masksToBounds = YES;
    
    maleRadio.layer.cornerRadius = maleRadio.frame.size.height/2;
    maleRadio.layer.masksToBounds = YES;
    
    masterScroller.contentSize = CGSizeMake(masterScroller.frame.size.width, signupHolder.frame.origin.y+signupHolder.frame.size.height);

    [dPicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
                                [UIDatePicker
                                 instanceMethodSignatureForSelector:selector]];
    BOOL no = NO;
    [invocation setSelector:selector];
    [invocation setArgument:&no atIndex:2];
    [invocation invokeWithTarget:dPicker];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fbDataDone) name:@"FBFETCHINGDONE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(googleSignInSucceed:) name:@"GPLUSSIGNUPDONE" object:nil];

}

-(void)googleSignInSucceed:(NSNotification *)notification{

    GIDAuthentication *auth = (GIDAuthentication *)[[notification userInfo]objectForKey:@"AUTH"];
    FIRAuthCredential *credential =
    [FIRGoogleAuthProvider credentialWithIDToken:auth.idToken
                                     accessToken:auth.accessToken];
    [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult,NSError * _Nullable error) {
        if (error) {
            [self->signupIndicator setHidden:YES];
            [self.view setUserInteractionEnabled:YES];
            [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
            return;
        }
        if (authResult == nil) {
            [self->signupIndicator setHidden:YES];
            [self.view setUserInteractionEnabled:YES];
            [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Authentication failed for google." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;

            return;
        }
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [[[[self.ref child:@"userPreferences"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if(snapshot.value!=[NSNull null]){
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
                app.window.rootViewController = view;
            }else{
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME1"];
                app.window.rootViewController = view;
            }
        }];
    }];

}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect hframe = masterScroller.frame;
        hframe.size.height = self.view.frame.size.height-50;
        masterScroller.frame = hframe;
    }else{
        CGRect hframe = masterScroller.frame;
        hframe.size.height = self.view.frame.size.height;
        masterScroller.frame = hframe;
    }
    return YES;
}

//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField==birthMonthTxt || textField==birthdayTxt || textField==birthYearTxt){
        [self.view endEditing:YES];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        if([app.isiphonex isEqualToString:@"YES"]){
            CGRect hframe = masterScroller.frame;
            hframe.size.height = self.view.frame.size.height-50;
            masterScroller.frame = hframe;
        }else{
            CGRect hframe = masterScroller.frame;
            hframe.size.height = self.view.frame.size.height;
            masterScroller.frame = hframe;
        }
        [datePickerView setHidden:NO];
        [UIView transitionWithView:datePickerHolder duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{

            CGRect frame = self->datePickerHolder.frame;
            frame.origin.y = self.view.frame.size.height-self->datePickerHolder.frame.size.height;
            self->datePickerHolder.frame = frame;
        }
        completion:nil];


        return NO;
    }else{
        CGRect frame = masterScroller.frame;
        frame.size.height = self.view.frame.size.height-216;
        masterScroller.frame = frame;
        return YES;
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==signupBtn){
        NSString *msg = @"";
        if(signupEmailTxt.text.length==0){
            msg = @"Oops! Please enter your email address.";
        }else if(signupPasswordTxt.text.length==0){
            msg = @"Oops! Please enter your password.";
        }else if(![self validateEmailWithString:signupEmailTxt.text]){
            msg = @"Oops! Please enter a valid email address.";
        }else if(firstNameTxt.text.length==0){
            msg = @"Oops! Please enter your first name.";
        }else if(lastNameTxt.text.length==0){
            msg = @"Oops! Please enter your last name.";
        }else if(maleBtn.tag==0 && femaleBtn.tag==0){
            msg = @"Oops! Please tell us your gender.";
        }
        if(msg.length>0){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
            return;
        }
        [signupIndicator setHidden:NO];
        [signupBtn setTitle:@"" forState:UIControlStateNormal];
        [self.view setUserInteractionEnabled:NO];
        [[FIRAuth auth] createUserWithEmail:signupEmailTxt.text password:signupPasswordTxt.text completion:^(FIRUser *user,NSError* error){
            if(error){
                [self->signupIndicator setHidden:YES];
                [self.view setUserInteractionEnabled:YES];
                [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                alert = nil;
            }else{
                NSString *gender = @"Male";
                if(self->maleBtn.tag==1){
                    gender = @"Male";
                }else if(self->femaleBtn.tag==1){
                    gender = @"Female";
                }
                NSString *contactPref = @"NA";
                if(self->exclusiveOfferBtn.tag==1){
                    contactPref = @"Exclusive Offers";
                }
                if(self->discountsBtn.tag==1){
                    contactPref = [NSString stringWithFormat:@"%@ and Discounts & sale",contactPref];
                }
                [[self.ref child:@"userData"].childByAutoId setValue:@{@"userid":[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid],@"firstName":self->firstNameTxt.text,@"lastName":self->lastNameTxt.text,@"birthDate":[NSString stringWithFormat:@"%@ %@, %@",self->birthdayTxt.text,self->birthMonthTxt.text,self->birthYearTxt.text],@"gender":gender,@"contactPreferences":contactPref}];
                
                [self->signupIndicator setHidden:YES];
                [self.view setUserInteractionEnabled:YES];
                [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
               
                NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
                [d setObject:self->signupEmailTxt.text forKey:@"email"];
                [d setObject:self->signupPasswordTxt.text forKey:@"password"];
                
                __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                [app deleteUser];
                [app saveuser:d];
               
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME1"];
                app.window.rootViewController = view;
            }
        }];
        
    }else if(sender==alreadyAccountBtn){
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"LOGINSCR"];
        app.window.rootViewController = view;
    }else if(sender==signupBackBtn){
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOMESCR"];
        app.window.rootViewController = view;
    }else if(sender==showPasswordBtn){
        if(showPasswordBtn.tag==0){
            [signupPasswordTxt setSecureTextEntry:NO];
            showPasswordBtn.tag=1;
        }else{
            [signupPasswordTxt setSecureTextEntry:YES];
            showPasswordBtn.tag=0;
        }
    }else if(sender==maleBtn){
        maleRadio.backgroundColor = signupBtn.backgroundColor;
        maleBtn.tag = 1;
        femaleBtn.tag = 0;
        femaleRadio.backgroundColor = [UIColor whiteColor];
    }else if(sender==femaleBtn){
        femaleRadio.backgroundColor = signupBtn.backgroundColor;
        femaleBtn.tag = 1;
        maleBtn.tag = 0;
        maleRadio.backgroundColor = [UIColor whiteColor];
    }else if(sender==exclusiveOfferBtn){
        if(exclusiveOfferBtn.tag==0){
            [exclusiveOfferRadio setImage:[UIImage imageNamed:@"radioon.jpg"]];
            exclusiveOfferBtn.tag = 1;
        }else{
            [exclusiveOfferRadio setImage:[UIImage imageNamed:@"radiooff.jpg"]];
            exclusiveOfferBtn.tag = 0;
        }
    }else if(sender==discountsBtn){
        if(discountsBtn.tag==0){
            [discountsRadio setImage:[UIImage imageNamed:@"radioon.jpg"]];
            discountsBtn.tag = 1;
        }else{
            [discountsRadio setImage:[UIImage imageNamed:@"radiooff.jpg"]];
            discountsBtn.tag = 0;
        }
    }else if(sender==dPickerCancel){
        [UIView transitionWithView:datePickerHolder duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->datePickerHolder.frame;
            frame.origin.y =self.view.frame.size.height;
            self->datePickerHolder.frame = frame;
        }completion:^(BOOL finished){
            [self->datePickerView setHidden:YES];
        }];

    }else if(sender==dPickerSelect){
        NSDate *date = dPicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"dd";
        birthdayTxt.text = [formatter stringFromDate:date];
        formatter.dateFormat = @"MMMM";
        birthMonthTxt.text = [formatter stringFromDate:date];
        formatter.dateFormat = @"YYYY";
        birthYearTxt.text = [formatter stringFromDate:date];
        [self buttonPressed:dPickerCancel];

    }else if(sender==signupFBBtn){
        isFBDone = NO;
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 [self->signupIndicator setHidden:YES];
                 [self.view setUserInteractionEnabled:YES];
                 [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert show];
                 alert = nil;
             } else if (result.isCancelled) {
                 [self->signupIndicator setHidden:YES];
                 [self.view setUserInteractionEnabled:YES];
                 [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
             } else {
                 __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 [app getFBData:result];
                 FIRAuthCredential *credential = [FIRFacebookAuthProvider
                credentialWithAccessToken:result.token.tokenString];
                 [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                completion:^(FIRAuthDataResult * _Nullable authResult,
                NSError * _Nullable error) {
                   if (error) {
                        [self->signupIndicator setHidden:YES];
                        [self.view setUserInteractionEnabled:YES];
                        [self->signupBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
                    if (authResult == nil) {
                        [self.view setUserInteractionEnabled:YES];
                        [self buttonPressed:self->signupBtn];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
                    if(isFBDone==YES){
                    [[[[self.ref child:@"userPreferences"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                        if(snapshot.value!=[NSNull null]){
                            UIStoryboard *story = self.storyboard;
                            UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
                            app.window.rootViewController = view;
                        }else{
                            UIStoryboard *story = self.storyboard;
                            UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME1"];
                            app.window.rootViewController = view;
                        }
                    }];
                    }else{
                        isFBDone = YES;
                    }
            }];

        }
        }];
    }else if(sender==signupGPlusBtn){
        [[GIDSignIn sharedInstance]signIn];
    }
}
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {

}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)fbDataDone{
    if(isFBDone==YES){
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [[[[self.ref child:@"userPreferences"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
            if(snapshot.value!=[NSNull null]){
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
                app.window.rootViewController = view;
            }else{
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME1"];
                app.window.rootViewController = view;
            }
        }];

    }else{
        isFBDone=YES;
    }

}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(signupEmailTxt.text.length>0 && signupPasswordTxt.text.length>0 && firstNameTxt.text.length>0 && lastNameTxt.text.length>0 && birthdayTxt.text.length>0 && birthMonthTxt.text.length>0 && birthYearTxt.text.length>0){
        [signupBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [signupBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(signupEmailTxt.text.length>0 && signupPasswordTxt.text.length>0 && firstNameTxt.text.length>0 && lastNameTxt.text.length>0 && birthdayTxt.text.length>0 && birthMonthTxt.text.length>0 && birthYearTxt.text.length>0){
        [signupBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [signupBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
