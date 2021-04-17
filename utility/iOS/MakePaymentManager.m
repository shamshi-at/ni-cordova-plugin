//
//  MakePaymentManager.m
//  MyApp
//
//  Created by Nikhil on 03/09/20.
//

#import "MakePaymentManager.h"

@interface MakePaymentManager ()<CardPaymentDelegate>
@property void (^NIDSdkPaymentStatusBlock) (enum PaymentStatus status);
@end

@implementation MakePaymentManager

/**
 This is initialisation function for NISdk Payment. This will show credit card view.
 @param orderResponseJSON need to pass CreateOrder API response JSON Data
 @param paymentStatusBlock will be PaymentStatus status block to return data
 
 */
- (instancetype)initWithCreateOrderPaymentResponse:(OrderResponse *)orderResponse withCompletionBlock:(NIDSdkPaymentStatusBlock)paymentStatusBlock {
    self = [super init];
    if(self) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            self.NIDSdkPaymentStatusBlock = paymentStatusBlock;
            NISdk *sdkInstance = [NISdk sharedInstance];
            [sdkInstance showCardPaymentViewWithCardPaymentDelegate:self overParent:self for: orderResponse];
        });
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

#pragma mark - NISDK Delegate method.
- (void)paymentDidCompleteWith:(enum PaymentStatus)status {
    NSLog(@"PaymentStatus :%d",status);
    [self dismissViewControllerAnimated:NO completion:^{
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if(status == PaymentStatusPaymentSuccess) {
                self.NIDSdkPaymentStatusBlock(status);
            } else if(status == PaymentStatusPaymentFailed) {
                self.NIDSdkPaymentStatusBlock(status);
            } else if(status == PaymentStatusPaymentCancelled) {
                self.NIDSdkPaymentStatusBlock(status);
            }
        });
    }];
}

@end
