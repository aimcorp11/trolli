//
//  ViewController.h
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@interface ViewController : UIViewController{
    IBOutlet UIButton *logInBtn,*joinUsBtn;
    IBOutlet UIActivityIndicatorView *autoLoginIndicator;
    
}
@property(nonatomic)IBOutlet UIActivityIndicatorView *autoLoginIndicator;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property(nonatomic)IBOutlet UIButton *logInBtn,*joinUsBtn;

@end

