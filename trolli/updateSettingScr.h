//
//  updateSettingScr.h
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@import Firebase;
@interface updateSettingScr : UIViewController{
    IBOutlet UIImageView *animatedTrolliIcon;
}
@property(nonatomic)IBOutlet UIImageView *animatedTrolliIcon;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

NS_ASSUME_NONNULL_END
