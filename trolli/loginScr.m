//
//  loginScr.m
//  trolli
//
//  Created by Himanshu Sharma on 29/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "loginScr.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface loginScr ()

@end

@implementation loginScr
@synthesize forgottenPassBtn,signInBtn;
@synthesize emailAddressTxt,passwordTxt;
@synthesize loginIndicator;
@synthesize loginHolder,loginBackBtn,loginTopView;
@synthesize loginFBBtn,loginGPlusBtn;
BOOL isDone;
- (void)viewDidLoad {
    [super viewDidLoad];
    [GIDSignIn sharedInstance].uiDelegate = self;
    self.ref = [[FIRDatabase database] reference];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = loginTopView.frame;
        frame.origin.y = 30;
        loginTopView.frame = frame;
        
        CGRect hframe = loginHolder.frame;
        hframe.origin.y = loginTopView.frame.origin.y+loginTopView.frame.size.height;
        hframe.size.height = self.view.frame.size.height-(hframe.origin.y+20);
        loginHolder.frame = hframe;
    }
    [loginGPlusBtn setStyle:kGIDSignInButtonStyleIconOnly];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fbDataDone) name:@"FBDATADONE" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(googleSignInSucceed:) name:@"GPLUSDONE" object:nil];
}

-(IBAction)googleSignIn{
    [[GIDSignIn sharedInstance] signIn];
}

-(void)googleSignInSucceed:(NSNotification *)notification{

    GIDAuthentication *auth = (GIDAuthentication *)[[notification userInfo]objectForKey:@"AUTH"];
    FIRAuthCredential *credential =
    [FIRGoogleAuthProvider credentialWithIDToken:auth.idToken
                                     accessToken:auth.accessToken];
    [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult,NSError * _Nullable error) {
        if (error) {
            [self->loginIndicator setHidden:YES];
            [self.view setUserInteractionEnabled:YES];
            [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
            return;
        }
        if (authResult == nil) {
            [self->loginIndicator setHidden:YES];
            [self.view setUserInteractionEnabled:YES];
            [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
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



// pressed the Sign In button
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

//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(emailAddressTxt.text.length>0 && passwordTxt.text.length>0){
        [signInBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [signInBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(emailAddressTxt.text.length>0 && passwordTxt.text.length>0){
        [signInBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [signInBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==signInBtn){
        NSString *msg = @"";
        if(emailAddressTxt.text.length==0){
            msg = @"Oops! Seems like you forgot to enter email address.";
        }else if(passwordTxt.text.length==0){
            msg = @"Oops! Seems like you forgot to enter password.";
        }else if([self validateEmailWithString:emailAddressTxt.text]==NO){
            msg = @"Oops! Please enter a valid email address.";
        }
        if(msg.length>0){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
            return;
        }
        [signInBtn setTitle:@"" forState:UIControlStateNormal];
        [loginIndicator setHidden:NO];
        [self.view setUserInteractionEnabled:NO];
        [[FIRAuth auth] signInWithEmail:emailAddressTxt.text password:passwordTxt.text completion:^(FIRUser *user, NSError *error){
            if(error){
                [self.view setUserInteractionEnabled:YES];
                [self->loginIndicator setHidden:YES];
                [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                alert = nil;
                
            }else{
                
                [[[[self.ref child:@"userData"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                    if(snapshot.value!=[NSNull null]){
                        
                        for (NSDictionary *snap in [snapshot.value allValues]) {
                            __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                            app.userData = [[NSMutableDictionary alloc]initWithDictionary:snap];
                            
                            [self.view setUserInteractionEnabled:YES];
                            [self->loginIndicator setHidden:YES];
                            [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
                            
                            NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
                            [d setObject:self->emailAddressTxt.text forKey:@"email"];
                            [d setObject:self->passwordTxt.text forKey:@"password"];
                            [app deleteUser];
                            [app saveuser:d];

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
                        }
                    }else{
                        
                    }
                }];
            }
        }];
    }else if(sender==forgottenPassBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController * view = [story instantiateViewControllerWithIdentifier:@"FORGOTPASSSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==loginBackBtn){
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOMESCR"];
        app.window.rootViewController = view;
    }else if(sender==loginFBBtn){
        isDone = NO;
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if (error) {
                 [self->loginIndicator setHidden:YES];
                 [self.view setUserInteractionEnabled:YES];
                 [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                 [alert show];
                 alert = nil;
             } else if (result.isCancelled) {
                 [self->loginIndicator setHidden:YES];
                 [self.view setUserInteractionEnabled:YES];
                 [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
             } else {
                 __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                 [app getFBData:result];

                 FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                                  credentialWithAccessToken:result.token.tokenString];
                 [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
                    completion:^(FIRAuthDataResult * _Nullable authResult,
                    NSError * _Nullable error) {
                    if (error) {
                        [self->loginIndicator setHidden:YES];
                        [self.view setUserInteractionEnabled:YES];
                        [self->signInBtn setTitle:@"SIGN IN" forState:UIControlStateNormal];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
                    if (authResult == nil) {
                        [self.view setUserInteractionEnabled:YES];
                        [self buttonPressed:self->signInBtn];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Authentication failed for facebook." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                        alert = nil;
                        return;
                    }
                        if(isDone==YES){
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
                            isDone = YES;
                        }
           }];
        }
      }];
    }
}

-(void)fbDataDone{
    if(isDone==YES){
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
        isDone = YES;
    }
}

-(void)didReceiveMemoryWarning {
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
