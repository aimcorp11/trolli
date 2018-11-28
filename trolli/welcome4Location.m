//
//  welcome4Location.m
//  trolli
//
//  Created by apple on 09/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "welcome4Location.h"
#import "AppDelegate.h"
#import "UIImage+animatedGIF.h"
@interface welcome4Location ()

@end

@implementation welcome4Location
@synthesize locationNextBtn;
@synthesize animatedLocIcon;
- (void)viewDidLoad {
    [super viewDidLoad];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = locationNextBtn.frame;
        frame.origin.y = locationNextBtn.frame.origin.y-20;
        locationNextBtn.frame = frame;
    }
    NSString *imgPath = [[NSBundle mainBundle]pathForResource:@"point" ofType:@"gif"];
    NSURL *imgURL = [NSURL fileURLWithPath:imgPath];
    UIImage *img = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:imgURL]];
    animatedLocIcon.image = img;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(locationPermissionDone) name:@"LOCPERMDONE" object:nil];

}
//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)locationPermissionDone{
      __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    UIStoryboard *story = self.storyboard;
    UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME5SCR"];
    app.window.rootViewController = view;
}
-(IBAction)buttonPressed:(id)sender{
    if(sender==locationNextBtn){
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [app startLocationTracking];



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
