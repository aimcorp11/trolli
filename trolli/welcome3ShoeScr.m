//
//  welcome3ShoeScr.m
//  trolli
//
//  Created by apple on 09/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "welcome3ShoeScr.h"
#import "AppDelegate.h"
@interface welcome3ShoeScr ()

@end

@implementation welcome3ShoeScr
@synthesize shoeSizeNextBtn,btnsize1,btnsize1point5,btnsize2,btnsize2point5,btnsize3,btnsize3point5,btnsize4,btnsize4point5,btnsize5,btnsize5point5,btnsize6,btnsize6point5,btnsize7,btnsize7point5,btnsize8,btnsize8point5,btnsize9,btnsize9point5,btnsize10,btnsize10point5,btnsize11,btnsize11point5,btnsize12,btnsize12point5,btnsize13,btnsize13point5;
@synthesize shoeSizeHolder;
NSString *shoeSize;
UIColor *basicColor;
- (void)viewDidLoad {
    [super viewDidLoad];
    basicColor = btnsize1point5.backgroundColor;
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect frame = shoeSizeNextBtn.frame;
        frame.origin.y = shoeSizeNextBtn.frame.origin.y-20;
        shoeSizeNextBtn.frame = frame;
    }
    
    CGRect frame = shoeSizeHolder.frame;
    frame.origin.x = 10;
    frame.size.width = self.view.frame.size.width-20;
    frame.size.height =self.view.frame.size.width-20;
    shoeSizeHolder.frame = frame;
    
    
    // Do any additional setup after loading the view.
}
//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==shoeSizeNextBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOME4"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.shoeSizePref = shoeSize;
        app.window.rootViewController = view;
    }
}

-(void)resetTags{
    btnsize1.tag=0;
    btnsize2.tag=0;
    btnsize3.tag=0;
    btnsize4.tag=0;
    btnsize5.tag=0;
    btnsize6.tag=0;
    btnsize7.tag=0;
    btnsize8.tag=0;
    btnsize9.tag=0;
    btnsize10.tag=0;
    btnsize11.tag=0;
    btnsize12.tag=0;
    btnsize13.tag=0;
    btnsize1point5.tag=0;
    btnsize2point5.tag= 0;
    btnsize3point5.tag=0;
    btnsize4point5.tag=0;
    btnsize5point5.tag=0;
    btnsize6point5.tag=0;
    btnsize7point5.tag=0;
    btnsize8point5.tag=0;
    btnsize9point5.tag=0;
    btnsize10point5.tag=0;
    btnsize11point5.tag=0;
    btnsize12point5.tag=0;
    btnsize13point5.tag=0;
    
    [btnsize1 setBackgroundColor:basicColor];
    [btnsize1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize2 setBackgroundColor:basicColor];
    [btnsize2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize3 setBackgroundColor:basicColor];
    [btnsize3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize4 setBackgroundColor:basicColor];
    [btnsize4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize5 setBackgroundColor:basicColor];
    [btnsize5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize6 setBackgroundColor:basicColor];
    [btnsize6 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize7 setBackgroundColor:basicColor];
    [btnsize7 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize8 setBackgroundColor:basicColor];
    [btnsize8 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize9 setBackgroundColor:basicColor];
    [btnsize9 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize10 setBackgroundColor:basicColor];
    [btnsize10 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize11 setBackgroundColor:basicColor];
    [btnsize11 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize12 setBackgroundColor:basicColor];
    [btnsize12 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btnsize13 setBackgroundColor:basicColor];
    [btnsize13 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize1point5 setBackgroundColor:basicColor];
    [btnsize1point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize2point5 setBackgroundColor:basicColor];
    [btnsize2point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize3point5 setBackgroundColor:basicColor];
    [btnsize3point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize4point5 setBackgroundColor:basicColor];
    [btnsize4point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize5point5 setBackgroundColor:basicColor];
    [btnsize5point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize6point5 setBackgroundColor:basicColor];
    [btnsize6point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize7point5 setBackgroundColor:basicColor];
    [btnsize7point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize8point5 setBackgroundColor:basicColor];
    [btnsize8point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize9point5 setBackgroundColor:basicColor];
    [btnsize9point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize10point5 setBackgroundColor:basicColor];
    [btnsize10point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize11point5 setBackgroundColor:basicColor];
    [btnsize11point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize12point5 setBackgroundColor:basicColor];
    [btnsize12point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btnsize13point5 setBackgroundColor:basicColor];
    [btnsize13point5 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(IBAction)sizeBtnTapped:(id)sender{
    if(sender==btnsize1){
        [self resetTags];
        btnsize1.tag=1;
        [btnsize1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize1 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"1";
    }else if(sender==btnsize1point5){
        [self resetTags];
        btnsize1point5.tag=1;
        [btnsize1point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize1point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"1.5";
    }else if(sender==btnsize2){
        [self resetTags];
        btnsize2.tag=1;
        [btnsize2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize2 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"2";
    }else if(sender==btnsize2point5){
        [self resetTags];
        btnsize2point5.tag=1;
        [btnsize2point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize2point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"2.5";
    }else if(sender==btnsize3){
        [self resetTags];
        btnsize3.tag=1;
        [btnsize3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize3 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"3";
    }else if(sender==btnsize3point5){
        [self resetTags];
        btnsize3point5.tag=1;
        [btnsize3point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize3point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"3.5";
    }else if(sender==btnsize4){
        [self resetTags];
        btnsize4.tag=1;
        [btnsize4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize4 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"4";
    }else if(sender==btnsize4point5){
        [self resetTags];
        btnsize4point5.tag=1;
        [btnsize4point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize4point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"4.5";
    }else if(sender==btnsize5){
        [self resetTags];
        btnsize5.tag=1;
        [btnsize5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"5";
    }else if(sender==btnsize5point5){
        [self resetTags];
        btnsize5point5.tag=1;
        [btnsize5point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize5point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"5.5";
    }else if(sender==btnsize6){
        [self resetTags];
        btnsize6.tag=1;
        [btnsize6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize6 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"6";
    }else if(sender==btnsize6point5){
        [self resetTags];
        btnsize6point5.tag=1;
        [btnsize6point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize6point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"6.5";
    }else if(sender==btnsize7){
        [self resetTags];
        btnsize7.tag=1;
        [btnsize7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize7 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"7";
    }else if(sender==btnsize7point5){
        [self resetTags];
        btnsize7point5.tag=1;
        [btnsize7point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize7point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"7.5";
    }else if(sender==btnsize8){
        [self resetTags];
        btnsize8.tag=1;
        [btnsize8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize8 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"8";
    }else if(sender==btnsize8point5){
        [self resetTags];
        btnsize8point5.tag=1;
        [btnsize8point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize8point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"8.5";
    }else if(sender==btnsize9){
        [self resetTags];
        btnsize9.tag=1;
        [btnsize9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize9 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"9";
    }else if(sender==btnsize9point5){
        [self resetTags];
        btnsize9point5.tag=1;
        [btnsize9point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize9point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"9.5";
    }else if(sender==btnsize10){
        [self resetTags];
        btnsize10.tag=1;
        [btnsize10 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize10 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"10";
    }else if(sender==btnsize10point5){
        [self resetTags];
        btnsize10point5.tag=1;
        [btnsize10point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize10point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"10.5";
    }else if(sender==btnsize11){
        [self resetTags];
        btnsize11.tag=1;
        [btnsize11 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize11 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"11";
    }else if(sender==btnsize11point5){
        [self resetTags];
        btnsize11point5.tag=1;
        [btnsize11point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize11point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"11.5";
    }else if(sender==btnsize12){
        [self resetTags];
        btnsize12.tag=1;
        [btnsize12 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize12 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"12";
    }else if(sender==btnsize12point5){
        [self resetTags];
        btnsize12point5.tag=1;
        [btnsize12point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize12point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"12.5";
    }else if(sender==btnsize13){
        [self resetTags];
        btnsize13.tag=1;
        [btnsize13 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize13 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"13";
    }else if(sender==btnsize13point5){
        [self resetTags];
        btnsize13point5.tag=1;
        [btnsize13point5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnsize13point5 setBackgroundColor:[UIColor whiteColor]];
        [shoeSizeNextBtn setHidden:NO];
        shoeSize = @"13.5";
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
