//
//  ViewController.m
//  notifyApp
//
//  Created by SnehaPriya Ale on 1/31/17.
//  Copyright © 2017 snehapriyaale. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *timeText;

-(void)requestNotify;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestNotify {
    UIMutableUserNotificationAction *snoozeAction = [[UIMutableUserNotificationAction alloc]init];
    snoozeAction.identifier = @"SNOOZE_ACTION";
    snoozeAction.title = @"View";
    snoozeAction.activationMode = UIUserNotificationActivationModeForeground;
    snoozeAction.destructive = YES;
    snoozeAction.authenticationRequired = NO;
    
    UIMutableUserNotificationAction *dismissAction = [[UIMutableUserNotificationAction alloc]init];
    dismissAction.identifier = @"DISMISS_ACTION";
    dismissAction.title = @"DISMISS";
    dismissAction.activationMode = UIUserNotificationActivationModeBackground;
    dismissAction.destructive = NO;
    dismissAction.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc]init];
    category.identifier = @"Time_category";
    [category setActions:@[snoozeAction,dismissAction] forContext:UIUserNotificationActionContextDefault];
    
    NSSet *categorySet = [NSSet setWithObjects:category, nil];
    
    UIUserNotificationType types =  UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categorySet];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
}
- (IBAction)setAlarmAction:(UIButton *)sender {
    if(self.timeText.text){
        [self requestNotify];
        [self createNotification:[self.timeText.text intValue]];
    }
}

- (void)createNotification: (int)seconds {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:seconds];
    localNotif.timeZone = nil;
    localNotif.alertTitle = @"Alert Title";
    localNotif.alertBody = @"Alert Body";
    localNotif.alertAction = @"Ok";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.category = @"Time_category";
    localNotif.applicationIconBadgeNumber = 12;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

@end
