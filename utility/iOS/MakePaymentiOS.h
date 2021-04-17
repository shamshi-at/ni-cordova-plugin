//
//  MakePaymentiOS.h
//  Payment
//
//  Created by Pratik on 23/08/20.
//  Copyright © 2020 LN-MCBK-004. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NISdk/NISdk-Swift.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^NIDSdkPaymentStatusBlock) (enum PaymentStatus status);

@interface MakePaymentiOS : UIViewController

- (instancetype)initWithCreateOrderPaymentResponse:(NSData *)orderResponseData parent:(UIViewController *)parent withCompletionBlock:(NIDSdkPaymentStatusBlock)paymentStatusBlock;
@end

NS_ASSUME_NONNULL_END
