//
//  welcome5Scr.m
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "welcome5Scr.h"
#import "AppDelegate.h"
@interface welcome5Scr ()

@end

@implementation welcome5Scr
@synthesize enableNotifications;
@synthesize notifyIndicator;
- (void)viewDidLoad {
    [super viewDidLoad];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = enableNotifications.frame;
        frame.origin.y = enableNotifications.frame.origin.y-20;
        enableNotifications.frame = frame;

        CGRect nFrame = notifyIndicator.frame;
        nFrame.origin.y = notifyIndicator.frame.origin.y-20;
        notifyIndicator.frame = nFrame;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationProcessDone) name:@"NOTIFICATIONPROCESSDONE" object:nil];
}

-(void)notificationProcessDone{
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIStoryboard *story = self.storyboard;
    UIViewController *view = [story instantiateViewControllerWithIdentifier:@"UPDATESETTINGSCR"];
    app.window.rootViewController = view;
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==enableNotifications){
        [notifyIndicator setHidden:NO];
        [enableNotifications setTitle:@"" forState:UIControlStateNormal];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [app getDeviceToken];
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
