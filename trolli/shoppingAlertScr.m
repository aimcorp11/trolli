//
//  shoppingAlertScr.m
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "shoppingAlertScr.h"
#import "AppDelegate.h"
#import "CustomCollectionViewLayout.h"
@interface shoppingAlertScr ()

@end

@implementation shoppingAlertScr
@synthesize saTopView,saBottomBar;
@synthesize saScanBtn,saProfileBtn;
@synthesize sizeLargeBtn,sizeSmallBtn,sizeMediumBtn,sizeXLargeBtn,buyOverLay,buyProductImg;
@synthesize hideBuyOverlayBtn;
@synthesize collV;
@synthesize sacartCount;
@synthesize saCartBtn;
NSMutableArray *mosaicElements;
UIColor *normalSizeColor,*highSizeColor;
- (void)viewDidLoad {
    [super viewDidLoad];

   mosaicElements = [[NSMutableArray alloc]initWithObjects:@{@"imageFilename":@"pic1.jpg",@"size":@"3",@"title":@"0"},@{@"imageFilename":@"pic2.jpg",@"size":@"1",@"title":@"1"},@{@"imageFilename":@"pic3.jpg",@"size":@"3",@"title":@"2"},@{@"imageFilename":@"pic4.jpg",@"size":@"2",@"title":@"3"},@{@"imageFilename":@"pic5.jpg",@"size":@"3",@"title":@"4"},@{@"imageFilename":@"pic6.jpg",@"size":@"2",@"title":@"5"},@{@"imageFilename":@"pic7.jpg",@"size":@"3",@"title":@"6"},@{@"imageFilename":@"pic8.jpg",@"size":@"1",@"title":@"7"},@{@"imageFilename":@"pic1.jpg",@"size":@"3",@"title":@"8"},@{@"imageFilename":@"pic2.jpg",@"size":@"1",@"title":@"9"},@{@"imageFilename":@"pic3.jpg",@"size":@"3",@"title":@"10"},@{@"imageFilename":@"pic4.jpg",@"size":@"3",@"title":@"11"},@{@"imageFilename":@"pic5.jpg",@"size":@"2",@"title":@"12"},@{@"imageFilename":@"pic6.jpg",@"size":@"2",@"title":@"13"},@{@"imageFilename":@"pic7.jpg",@"size":@"3",@"title":@"14"},@{@"imageFilename":@"pic8.jpg",@"size":@"1",@"title":@"15"},@{@"imageFilename":@"pic1.jpg",@"size":@"3",@"title":@"0"},@{@"imageFilename":@"pic2.jpg",@"size":@"1",@"title":@"1"},@{@"imageFilename":@"pic3.jpg",@"size":@"3",@"title":@"2"},@{@"imageFilename":@"pic4.jpg",@"size":@"2",@"title":@"3"},@{@"imageFilename":@"pic5.jpg",@"size":@"3",@"title":@"4"},@{@"imageFilename":@"pic6.jpg",@"size":@"2",@"title":@"5"},@{@"imageFilename":@"pic7.jpg",@"size":@"3",@"title":@"6"},@{@"imageFilename":@"pic8.jpg",@"size":@"1",@"title":@"7"},@{@"imageFilename":@"pic1.jpg",@"size":@"3",@"title":@"8"},@{@"imageFilename":@"pic2.jpg",@"size":@"1",@"title":@"9"},@{@"imageFilename":@"pic3.jpg",@"size":@"3",@"title":@"10"},@{@"imageFilename":@"pic4.jpg",@"size":@"3",@"title":@"11"},@{@"imageFilename":@"pic5.jpg",@"size":@"2",@"title":@"12"},@{@"imageFilename":@"pic6.jpg",@"size":@"2",@"title":@"13"},@{@"imageFilename":@"pic7.jpg",@"size":@"3",@"title":@"14"},@{@"imageFilename":@"pic8.jpg",@"size":@"1",@"title":@"15"}, nil];

    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(app.cartArr.count>0){
        if(app.cartArr.count>9){
            sacartCount.text = @"9+";
        }else{
            sacartCount.text = [NSString stringWithFormat:@"%d",(int)app.cartArr.count];
        }
    }else{
        sacartCount.text = @"";
    }
    self.ref = [[FIRDatabase database] reference];

    normalSizeColor = sizeSmallBtn.backgroundColor;
    highSizeColor = saBottomBar.backgroundColor;
    
    if([app.isiphonex isEqualToString:@"YES"]){
        CGRect tvFrame = saTopView.frame;
        tvFrame.origin.y = 30;
        saTopView.frame = tvFrame;

        CGRect bbFrame = saBottomBar.frame;
        bbFrame.size.height = saBottomBar.frame.size.height+20;
        bbFrame.origin.y = self.view.frame.size.height-bbFrame.size.height;
        saBottomBar.frame = bbFrame;
    }
    CGRect mFrame = collV.frame;
    mFrame.origin.y = saTopView.frame.origin.y+saTopView.frame.size.height;
    mFrame.size.height = self.view.frame.size.height - (saBottomBar.frame.size.height+mFrame.origin.y);
    mFrame.size.width = self.view.frame.size.width;
//    mFrame.origin.x = (self.view.frame.size.width-itemsMosaic.frame.size.width)/2;
    collV.frame = mFrame;

    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc] initWithSize:collV.bounds.size];
   [collV setCollectionViewLayout:layout];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    UIImageView *img = (UIImageView *)[cell viewWithTag:100];
    img.image = [UIImage imageNamed:[[mosaicElements objectAtIndex:indexPath.row]objectForKey:@"imageFilename"]];
   
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *story = self.storyboard;
    UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SCANRESULTSCR"];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   
    app.window.rootViewController = view;

    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return mosaicElements.count;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
  
}

//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==saScanBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SCANCODESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==saProfileBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"PROFILESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==sizeSmallBtn){
        sizeSmallBtn.tag = 1;
        sizeMediumBtn.tag = 0;
        sizeLargeBtn.tag = 0;
        sizeXLargeBtn.tag = 0;
        
        [sizeSmallBtn setBackgroundColor:highSizeColor];
        [sizeMediumBtn setBackgroundColor:normalSizeColor];
        [sizeLargeBtn setBackgroundColor:normalSizeColor];
        [sizeXLargeBtn setBackgroundColor:normalSizeColor];
    }else if(sender==sizeMediumBtn){
        sizeSmallBtn.tag = 0;
        sizeMediumBtn.tag = 1;
        sizeLargeBtn.tag = 0;
        sizeXLargeBtn.tag = 0;
        
        [sizeSmallBtn setBackgroundColor:normalSizeColor];
        [sizeMediumBtn setBackgroundColor:highSizeColor];
        [sizeLargeBtn setBackgroundColor:normalSizeColor];
        [sizeXLargeBtn setBackgroundColor:normalSizeColor];
    }else if(sender==sizeLargeBtn){
        sizeSmallBtn.tag = 0;
        sizeMediumBtn.tag = 0;
        sizeLargeBtn.tag = 1;
        sizeXLargeBtn.tag = 0;
        
        [sizeSmallBtn setBackgroundColor:normalSizeColor];
        [sizeMediumBtn setBackgroundColor:normalSizeColor];
        [sizeLargeBtn setBackgroundColor:highSizeColor];
        [sizeXLargeBtn setBackgroundColor:normalSizeColor];
    }else if(sender==sizeXLargeBtn){
        sizeSmallBtn.tag = 0;
        sizeMediumBtn.tag = 0;
        sizeLargeBtn.tag = 0;
        sizeXLargeBtn.tag = 1;
        
        [sizeSmallBtn setBackgroundColor:normalSizeColor];
        [sizeMediumBtn setBackgroundColor:normalSizeColor];
        [sizeLargeBtn setBackgroundColor:normalSizeColor];
        [sizeXLargeBtn setBackgroundColor:highSizeColor];
    }else if(sender==hideBuyOverlayBtn){
        [buyOverLay setHidden:YES];
    }else if(sender==saCartBtn){
       

    }
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
