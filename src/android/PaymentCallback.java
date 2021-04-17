package com.btpl.plugins.ni;

import org.json.JSONObject;

public interface PaymentCallback {
    void onSuccess(JSONObject jsonObject);
    void onFail(String str);


}
