//
//  ViewController.m
//  fingerprintLogin
//
//  Created by Naveen Kumar on 08/02/15.
//  Copyright (c) 2015 track. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
{
    LAContext *context;
    UIAlertView *errorAlert,*successAlert,*warningError,*lowDeviceAlert;
}
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginButton:(id)sender;


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

- (IBAction)loginButton:(id)sender {
    context = [[LAContext alloc] init];
    NSError *error = nil;
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Is this device belongs to you?"
                          reply:^(BOOL success, NSError *error) {
                              if(error){
                                  errorAlert = [[UIAlertView alloc] initWithTitle:@"Finger Print"
                                                                                  message:@"There is a problem verifying your ID.Please try again"
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                                  [errorAlert show];
                                  return;
                              }
                              if(success){
                                  successAlert = [[UIAlertView alloc] initWithTitle:@"Finger Print"
                                                                                  message:@"Finger Print Verified successfully"
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                                  [successAlert show];
                              } else {
                                  warningError = [[UIAlertView alloc] initWithTitle:@"Finger Print"
                                                                                  message:@"Invalid login."
                                                                                 delegate:nil
                                                                        cancelButtonTitle:@"Ok"
                                                                        otherButtonTitles:nil];
                                  [warningError show];
                              }
                          }];
    } else {
        lowDeviceAlert = [[UIAlertView alloc] initWithTitle:@"Finger Print"
                                                        message:@"Your device not support  TouchID."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [lowDeviceAlert show];
    }
}
@end
