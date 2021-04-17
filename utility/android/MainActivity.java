/*
       Licensed to the Apache Software Foundation (ASF) under one
       or more contributor license agreements.  See the NOTICE file
       distributed with this work for additional information
       regarding copyright ownership.  The ASF licenses this file
       to you under the Apache License, Version 2.0 (the
       "License"); you may not use this file except in compliance
       with the License.  You may obtain a copy of the License at

         http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing,
       software distributed under the License is distributed on an
       "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
       KIND, either express or implied.  See the License for the
       specific language governing permissions and limitations
       under the License.
 */

package io.ionic.starter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

import com.btpl.plugins.ni.PaymentCallback;

import org.apache.cordova.*;
import org.jetbrains.annotations.Nullable;
import org.json.JSONException;
import org.json.JSONObject;

import payment.sdk.android.PaymentClient;
import payment.sdk.android.cardpayment.CardPaymentData;
import payment.sdk.android.cardpayment.CardPaymentRequest;

public class MainActivity extends CordovaActivity {
    static Activity context;
    static private PaymentCallback paymentCallback;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        context = (Activity) this;
        // enable Cordova apps to be started in the background
        Bundle extras = getIntent().getExtras();
        if (extras != null && extras.getBoolean("cdvStartInBackground", false)) {
            moveTaskToBack(true);
        }

        // Set by <content src="index.html" /> in config.xml
        loadUrl(launchUrl);
    }

    public static void payment(String url, String code, PaymentCallback mPaymentCallback) {
        paymentCallback = mPaymentCallback;
        Toast.makeText(context, "Please Wait...", Toast.LENGTH_LONG).show();
        PaymentClient paymentClient = new PaymentClient(context);
        CardPaymentRequest request = new CardPaymentRequest.Builder()
                .gatewayUrl(url)
                .code(code)
                .build();
        paymentClient.launchCardPayment(request, 2001);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 2001 && resultCode == Activity.RESULT_OK) {
            CardPaymentData cardPaymentData = data.getParcelableExtra("data");

            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put("code", cardPaymentData.getCode());
                jsonObject.put("reason", cardPaymentData.getReason());
                paymentCallback.onSuccess(jsonObject);
            } catch (JSONException e) {
                paymentCallback.onFail("Something went wrong");
            }

//            if (cardPaymentData.getCode() == CardPaymentData.STATUS_PAYMENT_CAPTURED) {
//
//            }
//            if (cardPaymentData.getCode() == CardPaymentData.STATUS_GENERIC_ERROR) {
//
//            }
//            if (cardPaymentData.getCode() == CardPaymentData.STATUS_PAYMENT_AUTHORIZED) {
//
//            }
//            if (cardPaymentData.getCode() == CardPaymentData.STATUS_PAYMENT_FAILED) {
//
//            }
            }
        }
    }
