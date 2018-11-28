//
//  profileScr.m
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "profileScr.h"
#import "AppDelegate.h"
@interface profileScr ()

@end

@implementation profileScr
@synthesize proScanBtn,proShopBtn,proTopView,proBottomBar;
@synthesize profileHolderView;
@synthesize userPicHolder,tableHeader,proTbl;
@synthesize uNameLbl,uNameInitials;
@synthesize pCartCount;
@synthesize pCartBtn;
NSMutableArray *optionsArray,*optionsImgArray;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.ref = [[FIRDatabase database] reference];
     optionsArray = [[NSMutableArray alloc]initWithObjects:@"My shopping bag",@"Delivery",@"Payment methods",@"Gift cards & vouchers",@"My details",@"Sign out", nil];
    optionsImgArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"shoppingbagic.png"],[UIImage imageNamed:@"globeic.png"],[UIImage imageNamed:@"paymentic.png"],[UIImage imageNamed:@"giftcardic.png"],[UIImage imageNamed:@"detailsic.png"],[UIImage imageNamed:@"signoutic.png"], nil];

    //Identifying if device is iphonex and giving 30 pixel margin on top and bottom
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    if(app.cartArr.count>0){
        if(app.cartArr.count>9){
            pCartCount.text = @"9+";
        }else{
            pCartCount.text = [NSString stringWithFormat:@"%d",(int)app.cartArr.count];
        }
    }else{
        pCartCount.text = @"";
    }
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect protFrame = proTopView.frame;
        protFrame.origin.y = 30;
        proTopView.frame = protFrame;
        
        CGRect probFrame = proBottomBar.frame;
        probFrame.size.height = proBottomBar.frame.size.height+20;
        probFrame.origin.y = self.view.frame.size.height-probFrame.size.height;
        proBottomBar.frame = probFrame;
    }
    
    //Setting logged in user name, and name intials
    uNameLbl.text = [NSString stringWithFormat:@"%@ %@",[app.userData objectForKey:@"firstName"],[app.userData objectForKey:@"lastName"]];
    NSString *initials = @"";
    initials = [[app.userData objectForKey:@"firstName"] substringToIndex:1];
    NSString *lname = [app.userData objectForKey:@"lastName"];
    if(lname.length>0){
        initials = [NSString stringWithFormat:@"%@%@",initials,[[app.userData objectForKey:@"lastName"]substringToIndex:1]];
    }
    uNameInitials.text = [initials uppercaseString];
    
    //Setting profile view frame
    CGRect holderFrame = profileHolderView.frame;
    holderFrame.origin.y = proTopView.frame.origin.y+proTopView.frame.size.height;
    holderFrame.size.height = self.view.frame.size.height-(proBottomBar.frame.size.height+holderFrame.origin.y);
    profileHolderView.frame = holderFrame;
    
    //Making user initial view round programatically
    userPicHolder.layer.cornerRadius = userPicHolder.frame.size.height/2;
    userPicHolder.layer.masksToBounds = YES;
}

//TableView Delegate function, returns height of header view (The view which holds name and initials of user)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableHeader.frame.size.height;
}

//TableView delegate function, returns view for header(The view which holds name and initials of user)
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return tableHeader;
}

//TableView Datasource function, returns number of rows(OptionsArray which we set above on screen load)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return optionsArray.count;
}

//TableView Datasource function, returns height of row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

//TableView Delegate, called when user tap any of the option.
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==5){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure, you want to sign out from your Trolli account." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes",@"No", nil];
        [alert show];
    }
    [tableView reloadData];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
         NSError *signOutError;
        BOOL status = [[FIRAuth auth]signOut:&signOutError];
        if(status == YES){
            __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            [app deleteUser];
            UIStoryboard *story = self.storyboard;
            UIViewController *view = [story instantiateViewControllerWithIdentifier:@"WELCOMESCR"];
            app.window.rootViewController = view;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Oops! Something went wrong, please check your connection and try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            alert = nil;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UILabel *optionLbl = (UILabel *)[cell viewWithTag:100];
    UIImageView *optionImg = (UIImageView *)[cell viewWithTag:551];
    optionImg.image = (UIImage *)[optionsImgArray objectAtIndex:indexPath.row];
    optionLbl.text = [optionsArray objectAtIndex:indexPath.row];
    return cell;
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==proShopBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==proScanBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SCANCODESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==pCartBtn){
     

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
