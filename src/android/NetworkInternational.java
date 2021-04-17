package com.btpl.plugins.ni;

import android.graphics.Color;
import android.os.Handler;
import android.util.Log;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import io.ionic.starter.MainActivity;
import payment.sdk.android.PaymentClient;
import payment.sdk.android.cardpayment.CardPaymentRequest;

/**
 * This class echoes a string called from JavaScript.
 */
public class NetworkInternational extends CordovaPlugin {
    CallbackContext mCallbackContext;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        mCallbackContext = callbackContext;
        if (action.equals("makePayment")) {
            JSONObject jsonObject = args.getJSONObject(0);
            String url = jsonObject.getString("url");
            String code = jsonObject.getString("code");
            this.makePayment(url, code, callbackContext);
            return true;
        }
        return false;
    }

    private void makePayment(String url, String code, CallbackContext callbackContext) {

        if (url != null && url.length() > 0 && code != null && code.length() > 0) {
            MainActivity mainActivity = new MainActivity();
            mainActivity.payment(url, code, new PaymentCallback() {
                @Override
                public void onSuccess(JSONObject jsonObject) {
                    callbackContext.success(jsonObject);
                }

                @Override
                public void onFail(String str) {
                    callbackContext.error(str);
                }
            });
        } else {
            callbackContext.error("Expected url here");
        }
    }


}
