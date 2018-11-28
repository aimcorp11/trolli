//
//  updateSettingScr.m
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "updateSettingScr.h"
#import "UIImage+animatedGIF.h"
#import "AppDelegate.h"
@interface updateSettingScr ()

@end

@implementation updateSettingScr
@synthesize animatedTrolliIcon;
- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *imgPath = [[NSBundle mainBundle]pathForResource:@"Liam" ofType:@"gif"];
    NSURL *imgURL = [NSURL fileURLWithPath:imgPath];
    UIImage *img = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:imgURL]];
    animatedTrolliIcon.image = img;

    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(uploadDataToFIREBASE) withObject:nil afterDelay:4];

}

-(void)uploadDataToFIREBASE{
     self.ref = [[FIRDatabase database] reference];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(app.productTypePref.length>0){
        [[self.ref child:@"userPreferences"].childByAutoId setValue:@{@"userid":[NSString stringWithFormat:@"%@",[FIRAuth auth].currentUser.uid],@"shoeSizePref":app.shoeSizePref,@"productPref":app.productTypePref}];
        app.productTypePref = @"";
        app.shoeSizePref = @"";

       
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
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
