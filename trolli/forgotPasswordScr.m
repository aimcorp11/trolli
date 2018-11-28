//
//  forgotPasswordScr.m
//  trolli
//
//  Created by Himanshu Sharma on 31/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "forgotPasswordScr.h"
#import "AppDelegate.h"
@interface forgotPasswordScr ()

@end

@implementation forgotPasswordScr
@synthesize recoverBtn,recoverEmailTxt,recoverIndicator;
@synthesize forgottenHolder,forgottenBackBtn,forgottenTopView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [recoverEmailTxt becomeFirstResponder];
    
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame  = forgottenTopView.frame;
        frame.origin.y = 30;
        forgottenTopView.frame = frame;
        
        CGRect hframe = forgottenHolder.frame;
        hframe.origin.y = forgottenTopView.frame.size.height+forgottenTopView.frame.origin.y;
        hframe.size.height = self.view.frame.size.height - (hframe.origin.y+20);
        forgottenHolder.frame = hframe;
    }
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==recoverBtn){
        NSString *msg  = @"";
        if(recoverEmailTxt.text.length==0){
            msg = @"Oops! Please enter your registered email account.";
        }else if(![self validateEmailWithString:recoverEmailTxt.text]){
            msg = @"Oops! Please enter a valid email address";
        }
        if(msg.length>0){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
            return;
        }
        [recoverIndicator setHidden:NO];
        [recoverBtn setTitle:@"" forState:UIControlStateNormal];
        [recoverBtn setUserInteractionEnabled:NO];
        [[FIRAuth auth]sendPasswordResetWithEmail:recoverEmailTxt.text completion:^(NSError *error){
            if(error){
                [self->recoverIndicator setHidden:YES];
                [self->recoverBtn setUserInteractionEnabled:YES];
                [self->recoverBtn setTitle:@"RECOVER" forState:UIControlStateNormal];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
            }else{
                [self->recoverIndicator setHidden:YES];
                [self->recoverBtn setUserInteractionEnabled:YES];
                [self->recoverBtn setTitle:@"RECOVER" forState:UIControlStateNormal];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"We have sent you password link, please check your inbox." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                UIStoryboard *story = self.storyboard;
                UIViewController *view = [story instantiateViewControllerWithIdentifier:@"LOGINSCR"];
                __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                app.window.rootViewController = view;
                
            }
        }];
        
    }else if(sender==forgottenBackBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"LOGINSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if(recoverEmailTxt.text.length>0){
        [recoverBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [recoverBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(recoverEmailTxt.text.length>0){
        [recoverBtn setBackgroundColor:[UIColor colorWithRed:0.11 green:0.52 blue:0.48 alpha:1.0]];
    }else{
        [recoverBtn setBackgroundColor:
         [UIColor colorWithRed:0.39 green:0.39 blue:0.39 alpha:1.0]];
    }
    return YES;
}
//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
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
