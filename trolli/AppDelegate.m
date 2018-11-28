//
//  AppDelegate.m
//  trolli
//
//  Created by Himanshu Sharma on 27/10/18.
//  Copyright © 2018 CodeBreaker. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize isiphonex;
@synthesize userData;
@synthesize database,databasePath;
@synthesize locManager;
@synthesize addrCity;
@synthesize fullAddr;
@synthesize shoeSizePref,productTypePref;
@synthesize ddeviceToken;
@synthesize resultDict;
@synthesize cartArr;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];

    cartArr = [[NSMutableArray alloc]init];
    [GIDSignIn sharedInstance].clientID = @"598256830364-qina6t4sfe3ijk2of5pb9vg41do1htgq.apps.googleusercontent.com";
    [GIDSignIn sharedInstance].delegate = self;

    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];

    if([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height) {
            case 1136:
                printf("iPhone 5 or 5S or 5C");
                isiphonex = @"NO";
                break;
            case 1334:
                printf("iPhone 6/6S/7/8");
                isiphonex = @"NO";
                break;
            case 2208:
                printf("iPhone 6+/6S+/7+/8+");
                isiphonex = @"NO";
                break;
            case 2436:
                printf("iPhone X");
                isiphonex = @"YES";
                break;
            default:
                isiphonex = @"NO";
                printf("unknown");
        }
    }
    [self createTables];
    return YES;
}

-(void)getDeviceToken{
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }else{

        if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        {
            // iOS 8 Notifications
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];

            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            // iOS < 8 Notifications
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
        }
    }
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

    NSString *dToken = [NSString stringWithFormat:@"%@", deviceToken];
    dToken = [dToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    dToken = [dToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    dToken = [dToken stringByReplacingOccurrencesOfString:@" " withString:@""];

    ddeviceToken = dToken;
    @try{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATIONPROCESSDONE" object:nil];
    }@catch(NSException *r){}
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    ddeviceToken = @"";
    @try{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NOTIFICATIONPROCESSDONE" object:nil];
    }@catch(NSException *r){}
}

-(void)getFBData:(FBSDKLoginManagerLoginResult *)result{
    if ([result.grantedPermissions containsObject:@"public_profile"]) {
        if ([FBSDKAccessToken currentAccessToken]) {
            NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
            [parameters setValue:@"name,picture.type(large)" forKey:@"fields"];

            [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 if (!error)
                 {
                     NSLog(@"fetched user:%@", result);


                     NSString *name = [result valueForKey:@"name"];
                     NSString *username = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
                     NSArray *picture_arr = [result objectForKey:@"picture"];
                     NSArray *data_arr = [picture_arr valueForKey:@"data"];
                     NSString *profile_pic = [data_arr valueForKey:@"url"];

                     self->userData = [[NSMutableDictionary alloc]init];
                     NSArray *bits = [name componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
                     [self->userData setObject:[bits firstObject] forKey:@"firstName"];
                     if(bits.count>1){
                         [self->userData setObject:[bits objectAtIndex:1] forKey:@"lastName"];
                     }else{
                         [self->userData setObject:@"" forKey:@"lastName"];
                     }

                     @try{
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"FBDATADONE" object:nil];
                     }@catch(NSException *r){

                     }
                    @try{
                     [[NSNotificationCenter defaultCenter]postNotificationName:@"FBFETCHINGDONE" object:nil];
                    }@catch(NSException *r){

                    }
                 }

             }];
        }
    }
}


- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations on signed in user here.
   GIDAuthentication *authentication = user.authentication;
     NSString *name = user.profile.name;
     self->userData = [[NSMutableDictionary alloc]init];
     NSArray *bits = [name componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
     [self->userData setObject:[bits firstObject] forKey:@"firstName"];
     if(bits.count>1){
        [self->userData setObject:[bits objectAtIndex:1] forKey:@"lastName"];
     }else{
        [self->userData setObject:@"" forKey:@"lastName"];
     }
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:authentication forKey:@"AUTH"];
    @try{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GPLUSDONE" object:nil userInfo:dict];
    }@catch(NSException *r){}
    @try{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GPLUSSIGNUPDONE" object:nil userInfo:dict];
    }@catch(NSException *r){}
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
} 

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}


-(void)startLocationTracking{
    locManager = [[CLLocationManager alloc]init];
    locManager.delegate = self;
    locManager.pausesLocationUpdatesAutomatically = NO;
    locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if ([locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locManager requestWhenInUseAuthorization];
    }
    [locManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    @try{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LOCPERMDONE" object:nil];
    }@catch(NSException *r){}
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *nLocation = (CLLocation *)[locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:nLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = nil;
             
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             self->addrCity = [placemark subThoroughfare];
             if ([placemark.thoroughfare length] != 0)
             {
                 
                 // strAdd -> store value of current location
                 if ([strAdd length] != 0){
                     
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                     
                 }else
                 {
                     // strAdd -> store only this value,which is not null
                     strAdd = placemark.thoroughfare;
                     
                     
                 }
             }
             
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0){
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                     
                 }else{
                     strAdd = placemark.postalCode;
                 }
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0){
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                     self->addrCity = [placemark locality];
                 }else{
                     strAdd = placemark.locality;
                     self->addrCity = [placemark locality];
                 }
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0){
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 }else{
                     strAdd = placemark.administrativeArea;
                 }
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0){
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 }
                 else{
                     strAdd = placemark.country;
                 }
             }
             self->fullAddr = strAdd;
             BOOL isexist = [self isAddressAlreadySaved:self->addrCity addr:self->fullAddr];
             if(isexist==NO){
                 [self saveloc:self->addrCity Address:self->fullAddr];
             }
         }
     }];
}


-(void)createTables{
    
    NSString *documentdir;
    NSArray *documentPaths;
    
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath){
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    const char *defaultPath = [databasePath UTF8String];
    char *errMsg;
    
    if(sqlite3_open(defaultPath, &database)==SQLITE_OK){
        
        const char *create_Query1 = "CREATE TABLE IF NOT EXISTS USERDETAILS(email TEXT,password TEXT)";
        
        if(sqlite3_exec(database, create_Query1, NULL, NULL, &errMsg)!=SQLITE_OK){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Something went wrong, some features won't be available." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
            
            [alert show];
            alert = nil;
        }
        create_Query1 = nil;
        const char *create_Query2 = "CREATE TABLE IF NOT EXISTS LOCHISTORY(cityName TEXT,completeAddr TEXT)";
        
        if(sqlite3_exec(database, create_Query2, NULL, NULL, &errMsg)!=SQLITE_OK){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Something went wrong, some features won't be available." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
            
            [alert show];
            alert = nil;
        }
        create_Query2 = nil;
        sqlite3_close(database);
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Something went wrong, some features won't be available." delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
        if([[UIDevice currentDevice].systemVersion intValue]>6){
            [alert setTintColor:[UIColor colorWithRed:0.824 green:0.18 blue:0.231 alpha:1]];
        }
        [alert show];
        alert  = nil;
    }
}

-(BOOL)saveloc:(NSString *)city Address:(NSString *)addr{
    BOOL isSaved=NO;
    NSString *documentdir;
    NSArray *documentPaths;
    sqlite3_stmt *statement;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath)
    {
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath]==YES)
    {
        const char *defaultPath = [databasePath UTF8String];
        if(sqlite3_open(defaultPath, &database)==SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO LOCHISTORY(cityName,completeAddr) VALUES(\"%@\",\"%@\")",city,addr];
            const char *stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(database, stmt, -1, &statement, NULL);
            if(sqlite3_step(statement)==SQLITE_DONE)
            {
                isSaved=YES;
            }else{
                NSLog(@"%s",sqlite3_errmsg(database));
            }
        }
        sqlite3_close(database);
        fileManager = nil;
    }
    documentPaths = nil;
    documentdir = nil;
    return isSaved;
}




-(BOOL)saveuser:(NSMutableDictionary *)dict{
    BOOL isSaved=NO;
    NSString *documentdir;
    NSArray *documentPaths;
    sqlite3_stmt *statement;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath)
    {
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath]==YES)
    {
        const char *defaultPath = [databasePath UTF8String];
        if(sqlite3_open(defaultPath, &database)==SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO USERDETAILS(email,password) VALUES(\"%@\",\"%@\")",[dict objectForKey:@"email"],[dict objectForKey:@"password"]];
            const char *stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(database, stmt, -1, &statement, NULL);
            if(sqlite3_step(statement)==SQLITE_DONE)
            {
                isSaved=YES;
            }else{
                
                NSLog(@"%s",sqlite3_errmsg(database));
            }
        }
        sqlite3_close(database);
        fileManager = nil;
    }
    documentPaths = nil;
    documentdir = nil;
    return isSaved;
}

-(BOOL)deleteUser{
    BOOL isSaved=NO;
    NSString *documentdir;
    NSArray *documentPaths;
    sqlite3_stmt *statement;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath)
    {
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:databasePath]==YES)
    {
        const char *defaultPath = [databasePath UTF8String];
        if(sqlite3_open(defaultPath, &database)==SQLITE_OK)
        {
            NSString *insertSQL = [NSString stringWithFormat:@"DELETE FROM USERDETAILS"];
            const char *stmt = [insertSQL UTF8String];
            sqlite3_prepare_v2(database, stmt, -1, &statement, NULL);
            if(sqlite3_step(statement)==SQLITE_DONE)
            {
                isSaved=YES;
            }else{
                
                NSLog(@"%s",sqlite3_errmsg(database));
            }
        }
        sqlite3_close(database);
        fileManager = nil;
    }
    documentPaths = nil;
    documentdir = nil;
    return isSaved;
}

-(NSMutableDictionary *)getSavedUser{
    NSMutableDictionary *arr = [[NSMutableDictionary alloc]init];
    NSString *documentdir;
    NSArray *documentPaths;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath)
    {
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &database)==SQLITE_OK)
    {
        NSString *insertStatement = [NSString stringWithFormat:@"SELECT email,password FROM USERDETAILS"];
        const char *stmt = [insertStatement UTF8String];
        if(sqlite3_prepare_v2(database,stmt, -1,&statement,NULL)==SQLITE_OK)
        {
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                const char *objid = (char *)sqlite3_column_text(statement, 0);
                NSString *stobjId = [[NSString alloc]initWithUTF8String:objid];
                [arr setObject:stobjId forKey:@"email"];
                
                stobjId = nil;
                objid = nil;
                
                const char *objectid = (char *)sqlite3_column_text(statement, 1);
                NSString *stobjectId = [[NSString alloc]initWithUTF8String:objectid];
                [arr setObject:stobjectId forKey:@"password"];
                
                stobjectId=nil;
                objectid=nil;
            }
        }else{
            NSLog(@"%s",sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return arr;
}


-(BOOL)isAddressAlreadySaved:(NSString *)str addr:(NSString *)addr{
    BOOL isexist = NO;
    NSString *documentdir;
    NSArray *documentPaths;
    documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentdir = [documentPaths objectAtIndex:0];
    if(!databasePath)
    {
        databasePath = [[NSString alloc]initWithString:[documentdir stringByAppendingPathComponent:@"trollidb.db"]];
    }
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if(sqlite3_open(dbPath, &database)==SQLITE_OK)
    {
        NSString *insertStatement = [NSString stringWithFormat:@"SELECT cityName,completeAddr FROM LOCHISTORY WHERE cityName=%@ AND completeAddr=%@",str,addr];
        const char *stmt = [insertStatement UTF8String];
        if(sqlite3_prepare_v2(database,stmt, -1,&statement,NULL)==SQLITE_OK)
        {
            if(sqlite3_step(statement)==SQLITE_ROW)
            {
                
                isexist = YES;
            }
        }else{
            NSLog(@"%s",sqlite3_errmsg(database));
        }
        sqlite3_finalize(statement);
        sqlite3_close(database);
    }
    return isexist;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
