//
//  MakePaymentiOS.m
//  Payment
//
//  Created by Pratik on 23/08/20.
//  Copyright © 2020 LN-MCBK-004. All rights reserved.
//

#import "MakePaymentiOS.h"

@interface MakePaymentiOS ()<CardPaymentDelegate>
@property void (^NIDSdkPaymentStatusBlock) (enum PaymentStatus status);
@end

@implementation MakePaymentiOS
/**
 This is initialisation function for NISdk Payment. This will show credit card view.
 @param orderResponseJSON need to pass CreateOrder API response JSON Data
 @param paymentStatusBlock will be PaymentStatus status block to return data
 
 */
- (instancetype)initWithCreateOrderPaymentResponse:(NSDictionary *)orderResponseJSON withCompletionBlock:(NIDSdkPaymentStatusBlock)paymentStatusBlock {
    self = [super init];
    if(self) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CreateOrderResponse" ofType:@"json"];
            NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
            OrderResponse *createOrderResponse = [OrderResponse decodeFromData: jsonData error: nil];
            
            self.NIDSdkPaymentStatusBlock = paymentStatusBlock;
            NISdk *sdkInstance = [NISdk sharedInstance];
            [sdkInstance showCardPaymentViewWithCardPaymentDelegate:self overParent:self for:createOrderResponse];
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
