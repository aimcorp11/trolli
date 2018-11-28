//
//  scancodeScr.m
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "scancodeScr.h"
#import "AppDelegate.h"

@interface scancodeScr ()

@end

@implementation scancodeScr
@synthesize scanTopView,scanBottomBar;
@synthesize scanBarView;
@synthesize scShoppingBtn;
@synthesize scanLbl;
@synthesize scProfileBtn;
@synthesize loaderScreen;
@synthesize scCartCount;
@synthesize scannerIndicator;
@synthesize scCartBtn;
ZBarReaderViewController *reader;
BOOL isCallingBarcodable;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    isCallingBarcodable = NO;
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if(app.cartArr.count>0){
        if(app.cartArr.count>9){
            scCartCount.text = @"9+";
        }else{
            scCartCount.text = [NSString stringWithFormat:@"%d",(int)app.cartArr.count];
        }
    }else{
        scCartCount.text = @"";
    }

    if([app.isiphonex isEqualToString:@"YES"]){
        
        CGRect scTFrame = scanTopView.frame;
        scTFrame.origin.y = 30;
        scanTopView.frame = scTFrame;
        
        CGRect scBFrame = scanBottomBar.frame;
        scBFrame.size.height = scanBottomBar.frame.size.height+20;
        scBFrame.origin.y = self.view.frame.size.height-scBFrame.size.height;
        scanBottomBar.frame = scBFrame;
    }
    CGRect scanLblFrame = scanLbl.frame;
    scanLblFrame.origin.y = scanTopView.frame.origin.y+scanTopView.frame.size.height+20;
    scanLbl.frame = scanLblFrame;
}



//Hiding status bar on screen
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.view.frame = scanBarView.bounds;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.readerView.torchMode = 0;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [scanBarView addSubview:reader.view];
}

-(IBAction)buttonPressed:(id)sender{
    if(sender==scShoppingBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SHOPPINGALERTSCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==scProfileBtn){
        UIStoryboard *story = self.storyboard;
        UIViewController *view = [story instantiateViewControllerWithIdentifier:@"PROFILESCR"];
        __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        app.window.rootViewController = view;
    }else if(sender==scCartBtn){
       


    }
}

-(void)fetchProductsFromBarcodable:(NSString *)strr{
   
    NSString *urlStr = [NSString stringWithFormat:@"https://api.barcodelookup.com/v2/products?barcode=%@&formatted=y&key=l8kelx7dw35m5tbwug2i43rs6nylyo",strr];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSURLResponse *response;
    NSError *error;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response error:&error];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(!error){
        NSString *str = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    }else{
        NSLog(@"%@",error.description);
    }
    if(dict.count>0){
        [self performSelectorOnMainThread:@selector(fetchedProductSuccess:) withObject:dict waitUntilDone:NO];
    }else{
        [self performSelectorOnMainThread:@selector(noProductFound) withObject:nil waitUntilDone:NO];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    isCallingBarcodable = NO;
}

-(void)noProductFound{
    
    [loaderScreen setHidden:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Oops! We couldn't find the product." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}

-(void)fetchedProductSuccess:(NSMutableDictionary *)dict{
    [scannerIndicator setHidden:YES];
    isCallingBarcodable = NO;
    UIStoryboard *story = self.storyboard;
    UIViewController *view = [story instantiateViewControllerWithIdentifier:@"SCANRESULTSCR"];
    __unsafe_unretained AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.resultDict = dict;
    app.window.rootViewController = view;

}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
        isCallingBarcodable = YES;
        [self performSelectorInBackground:@selector(fetchProductsFromBarcodable:) withObject:symbol.data];

    
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
