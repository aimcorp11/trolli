//
//  ViewController.m
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize logInBtn,joinUsBtn;
@synthesize autoLoginIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    //Making login button edges round
    logInBtn.layer.cornerRadius = logInBtn.frame.size.height/2;
    logInBtn.layer.masksToBounds = YES;
    self.ref = [[FIRDatabase database] reference];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = joinUsBtn.frame;
        frame.origin.y  = joinUsBtn.frame.origin.y-20;
        joinUsBtn.frame = frame;

        CGRect lFrame = logInBtn.frame;
        lFrame.origin.y = logInBtn.frame.origin.y-20;
        logInBtn.frame = frame;
    }

    NSMutableDictionary *d = [app getSavedUser];
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [logInBtn setHidden:YES];
//        [joinUsBtn setHidden:YES];
//        [autoLoginIndicator setHidden:NO];
//        FIRAuthCredential *credential = [FIRFacebookAuthProvider
//                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken].tokenString];
//        [[FIRAuth auth] signInAndRetrieveDataWithCredential:credential
//                                                 completion:^(FIRAuthDataResult * _Nullable authResult,
//                                                              NSError * _Nullable error) {
//            if (error) {
//                [self.view setUserInteractionEnabled:YES];
//                [self buttonPressed:self->logInBtn];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                [alert show];
//                alert = nil;
//                return;
//            }
//            if (authResult == nil) {
//                [self.view setUserInteractionEnabled:YES];
//                [self buttonPressed:self->logInBtn];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                [alert show];
//                alert = nil;
//                return;
//            }
//                            [[[[self.ref child:@"userPreferences"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
//                            if(snapshot.value!=[NSNull null]){
//                                UIStoryboard *story = self.storyboard;
//                                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
//                                app.window.rootViewController = view;
//                            }else{
//                                UIStoryboard *story = self.storyboard;
//                                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME1"];
//                                app.window.rootViewController = view;
//                            }
//                           }];
//
//       }];

     if(d.count>0){
        [logInBtn setHidden:YES];
        [joinUsBtn setHidden:YES];
        [autoLoginIndicator setHidden:NO];
        [[FIRAuth auth] signInWithEmail:[d objectForKey:@"email"] password:[d objectForKey:@"password"] completion:^(FIRUser *user, NSError *error){
            if(error){
                [self.view setUserInteractionEnabled:YES];
                [self buttonPressed:self->logInBtn];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                alert = nil;
                
            }else{
                
                [[[[self.ref child:@"userData"] queryOrderedByChild:@"userid"] queryEqualToValue:[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid]] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
                    if(snapshot.value!=[NSNull null]){
                        
                        for (NSDictionary *snap in [snapshot.value allValues]) {
                            __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                            app.userData = [[NSMutableDictionary alloc]initWithDictionary:snap];

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
        
    }else{
        
    }
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==logInBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"LOGINSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==joinUsBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SIGNUPSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }
}

//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
