//
//  welcome2Scr.m
//  trolli
//
//  Created by apple on 08/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "welcome2Scr.h"
#import "AppDelegate.h"
@interface welcome2Scr ()

@end

@implementation welcome2Scr
@synthesize mensBtn,womensBtn,nextBtn;
UIColor *baseColor;
NSString *productTypeSel;
- (void)viewDidLoad {
    [super viewDidLoad];
    baseColor = mensBtn.backgroundColor;
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect nFrame = nextBtn.frame;
        nFrame.origin.y = nextBtn.frame.origin.y-20;
        nextBtn.frame = nFrame;
    }
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==mensBtn){
        mensBtn.tag=1;
        womensBtn.tag=0;
        [mensBtn setBackgroundColor:[UIColor whiteColor]];
        [mensBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [womensBtn setBackgroundColor:baseColor];
        [womensBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setHidden:NO];
        productTypeSel = @"Men";
    }else if(sender==womensBtn){
        mensBtn.tag=0;
        womensBtn.tag=1;
        [mensBtn setBackgroundColor:baseColor];
        [mensBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [womensBtn setBackgroundColor:[UIColor whiteColor]];
        [womensBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [nextBtn setHidden:NO];
        productTypeSel = @"Women";
    }else if(sender==nextBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME3"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.productTypePref = productTypeSel;
        app.window.rootViewController = view;
    }
}
//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
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
