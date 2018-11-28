//
//  scanResultScr.m
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "scanResultScr.h"
#import "AppDelegate.h"
#import "UIImage+animatedGIF.h"
@interface scanResultScr ()

@end

@implementation scanResultScr
@synthesize resultBackBtn,resultCostLbl,resultSizeBtn,resultTitleLbl,resultDescriptionLbl,pagerHolderView;
@synthesize resultImg;
@synthesize resultInfoView,resultBottomBarV;
@synthesize resultProfileBtn,resultScannerBtn,resultShopAlertBtn;
@synthesize sizeOptionView,hideSizeOptionsBtn,xlBtn,xsBtn,xxlBtn,sBtn,mBtn,lBtn;
@synthesize addToBagBtn;
@synthesize srCartCount;
@synthesize srCartBtn;
NSMutableDictionary *dictResult;
- (void)viewDidLoad {
    [super viewDidLoad];

    resultSizeBtn.layer.cornerRadius = 0;
    resultSizeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    resultSizeBtn.layer.borderWidth = 2;
    resultSizeBtn.layer.masksToBounds = YES;
  __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    if(app.cartArr.count>0){
        if(app.cartArr.count>9){
            srCartCount.text = @"9+";
        }else{
            srCartCount.text = [NSString stringWithFormat:@"%d",(int)app.cartArr.count];
        }
    }else{
        srCartCount.text = @"";
    }

    dictResult = app.resultDict;
    CGRect frame = pagerHolderView.frame;
    frame.size.height = self.view.frame.size.width+25;
    frame.size.width = self.view.frame.size.width;
    pagerHolderView.frame = frame;


    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = resultBottomBarV.frame;
        frame.size.height = resultBottomBarV.frame.size.height+20;
        resultBottomBarV.frame = frame;
    }
    CGRect rFrame = resultInfoView.frame;
    rFrame.size.height = resultBottomBarV.frame.origin.y-pagerHolderView.frame.size.height;
    rFrame.origin.y = pagerHolderView.frame.size.height;
    resultInfoView.frame = rFrame;

    if(dictResult.count>0){
        resultImg.image = nil;
        [self performSelectorInBackground:@selector(fetchProductImage:) withObject:dictResult];
        resultTitleLbl.text = [[[[dictResult objectForKey:@"products"] objectAtIndex:0] objectForKey:@"product_name"] uppercaseString];
        resultDescriptionLbl.text = [[[dictResult objectForKey:@"products"] objectAtIndex:0] objectForKey:@"description"];
    }

    // Do any additional setup after loading the view.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)fetchProductImage:(NSMutableDictionary *)dict{
    @try{
        NSArray *imagesArr = [[[dict objectForKey:@"products"] objectAtIndex:0] objectForKey:@"images"];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imagesArr firstObject]]]];
        if(img){
            [self performSelectorOnMainThread:@selector(setProductImage:) withObject:img waitUntilDone:NO];
        }
    }@catch(NSException *r){}
}

-(void)setProductImage:(UIImage *)img{
    @try{
        resultImg.image = img;
    }@catch(NSException *r){}
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==resultShopAlertBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==resultProfileBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"PROFILESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==resultScannerBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SCANCODESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==resultSizeBtn){
        [hideSizeOptionsBtn setHidden:NO];
        [UIView transitionWithView:sizeOptionView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->sizeOptionView.frame;
            frame.origin.y = (self.view.frame.size.height-self->sizeOptionView.frame.size.height)/2;
            self->sizeOptionView.frame = frame;
        }completion:nil];

    }else if(sender==hideSizeOptionsBtn){
        [hideSizeOptionsBtn setHidden:YES];
        [UIView transitionWithView:sizeOptionView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame = self->sizeOptionView.frame;
            frame.origin.y = self.view.frame.size.height;
            self->sizeOptionView.frame = frame;
        }completion:nil];
    }else if(sender==xsBtn){
        [resultSizeBtn setTitle:@"XS" forState:UIControlStateNormal];
        [addToBagBtn setHidden:NO];
        xsBtn.tag=1;
        sBtn.tag = 0;
        mBtn.tag=0;
        lBtn.tag=0;
        xlBtn.tag=0;
        xxlBtn.tag=0;
        [sBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==sBtn){
        [resultSizeBtn setTitle:@"S" forState:UIControlStateNormal];
        [addToBagBtn setHidden:NO];
        xsBtn.tag=0;
        sBtn.tag = 1;
        mBtn.tag=0;
        lBtn.tag=0;
        xlBtn.tag=0;
        xxlBtn.tag=0;
        [sBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==mBtn){
        [resultSizeBtn setTitle:@"M" forState:UIControlStateNormal];
        [addToBagBtn setHidden:NO];
        xsBtn.tag=0;
        sBtn.tag = 0;
        mBtn.tag=1;
        lBtn.tag=0;
        xlBtn.tag=0;
        xxlBtn.tag=0;
        [sBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==lBtn){
        [resultSizeBtn setTitle:@"L" forState:UIControlStateNormal];
        [addToBagBtn setHidden:NO];
        xsBtn.tag=0;
        sBtn.tag = 0;
        mBtn.tag=0;
        lBtn.tag=1;
        xlBtn.tag=0;
        xxlBtn.tag=0;
        [sBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==xlBtn){
        [addToBagBtn setHidden:NO];
        [resultSizeBtn setTitle:@"XL" forState:UIControlStateNormal];
        xsBtn.tag=0;
        sBtn.tag = 0;
        mBtn.tag=0;
        lBtn.tag=0;
        xlBtn.tag=1;
        xxlBtn.tag=0;
        [sBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==xxlBtn){
        [addToBagBtn setHidden:NO];
        [resultSizeBtn setTitle:@"XXL" forState:UIControlStateNormal];
        xsBtn.tag=0;
        sBtn.tag = 0;
        mBtn.tag=0;
        lBtn.tag=0;
        xlBtn.tag=0;
        xxlBtn.tag=1;
        [sBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [xxlBtn setTitleColor:[UIColor colorWithRed:0.39 green:0.38 blue:0.38 alpha:1.0] forState:UIControlStateNormal];
        [xsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self buttonPressed:hideSizeOptionsBtn];
    }else if(sender==addToBagBtn){

    }else if(sender==srCartBtn){

    }
}

-(void)moveToCartScreen{

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
