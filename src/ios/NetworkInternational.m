/********* NetworkInternational.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "MainViewController.h"
#import <NISdk/NISdk-Swift.h>

@interface NetworkInternational : CDVPlugin {
  // Member variables go here.
}

- (void)makePayment:(CDVInvokedUrlCommand*)command;
@end

@implementation NetworkInternational

- (void)makePayment:(CDVInvokedUrlCommand*)command
{
    __block CDVPluginResult* pluginResult = nil;
    NSDictionary *responseData = (NSDictionary *)[command.arguments objectAtIndex:0];
    NSLog(@"%@", responseData);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseData options:NSJSONWritingPrettyPrinted
      error:&error];
    
    MainViewController *vc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [vc startPaymentProcess_iOSWithOrderResponse:jsonData WithCompletionBlock:^(enum PaymentStatus status) {
        NSString *paymentStatus = @"";
        if(status == PaymentStatusPaymentSuccess) {
            paymentStatus = @"Payment Successfull";
            NSLog(@"***Payment Successfull***");

        } else if(status == PaymentStatusPaymentFailed) {
            paymentStatus = @"Payment Failed";
            NSLog(@"***Payment Failed***");
        } else if(status == PaymentStatusPaymentCancelled) {
            paymentStatus = @"Payment Aborted";
            NSLog(@"***Payment Aborted***");
        }
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"code" : @(status), @"reason" : paymentStatus}];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
    
    //if (echo != nil && [echo length] > 0) {

       // pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    //} else {
      //  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    //}

//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
