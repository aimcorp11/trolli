//
//  AppDelegate.h
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <CoreLocation/CoreLocation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UserNotifications/UserNotifications.h>
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@import Firebase;
@import GoogleSignIn;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,GIDSignInDelegate,UNUserNotificationCenterDelegate>{
    NSString *isiphonex;
    NSMutableDictionary *userData;
    NSString *databasePath;
    sqlite3 *database;
    CLLocationManager *locManager;
    NSString *addrCity,*fullAddr;
    NSString *productTypePref,*shoeSizePref;
    NSString *ddeviceToken;
    NSMutableDictionary *resultDict;
    NSMutableArray *cartArr;
}
@property(nonatomic)NSMutableArray *cartArr;
@property(nonatomic)NSMutableDictionary *resultDict;
@property(nonatomic)NSString *ddeviceToken;
@property(nonatomic)NSString *productTypePref,*shoeSizePref;
@property(nonatomic)NSString *addrCity,*fullAddr;
@property(nonatomic)CLLocationManager *locManager;
@property(nonatomic)NSString *databasePath;
@property(nonatomic)sqlite3 *database;
@property(nonatomic)NSMutableDictionary *userData;
@property(nonatomic)NSString *isiphonex;
@property (strong, nonatomic) UIWindow *window;
-(BOOL)saveuser:(NSMutableDictionary *)dict;
-(BOOL)deleteUser;
-(void)getFBData:(FBSDKLoginManagerLoginResult *)result;
-(NSMutableDictionary *)getSavedUser;
-(BOOL)saveloc:(NSString *)city Address:(NSString *)addr;
-(void)startLocationTracking;
-(void)getDeviceToken;

@end

