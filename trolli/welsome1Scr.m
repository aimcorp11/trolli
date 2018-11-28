//
//  welsome1Scr.m
//  trolli
//
//  Created by apple on 08/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "welsome1Scr.h"
#import "AppDelegate.h"
@interface welsome1Scr ()

@end

@implementation welsome1Scr
@synthesize getStartedBtn;
@synthesize welcomeLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    welcomeLbl.text = [NSString stringWithFormat:@"Welcome, %@",[app.userData objectForKey:@"firstName"]];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect gsFrame = getStartedBtn.frame;
        gsFrame.origin.y = getStartedBtn.frame.origin.y-20;
        getStartedBtn.frame = gsFrame;
    }
}
//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(IBAction)buttonPressed:(id)sender{
    if(sender==getStartedBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME2"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }

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
