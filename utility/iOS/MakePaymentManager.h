//
//  MakePaymentManager.h
//  MyApp
//
//  Created by Nikhil on 03/09/20.
//

#import <UIKit/UIKit.h>
#import <NISdk/NISdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^NIDSdkPaymentStatusBlock) (enum PaymentStatus status);
@interface MakePaymentManager : UIViewController
- (instancetype)initWithCreateOrderPaymentResponse:(OrderResponse *)orderResponse withCompletionBlock:(NIDSdkPaymentStatusBlock)paymentStatusBlock;
@end

NS_ASSUME_NONNULL_END
