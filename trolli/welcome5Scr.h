//
//  welcome5Scr.h
//  trolli
//
//  Created by apple on 17/11/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface welcome5Scr : UIViewController{
    IBOutlet UIButton *enableNotifications;
    IBOutlet UIActivityIndicatorView *notifyIndicator;
}
@property(nonatomic)IBOutlet UIActivityIndicatorView *notifyIndicator;
@property(nonatomic)IBOutlet UIButton *enableNotifications;
@end

NS_ASSUME_NONNULL_END
