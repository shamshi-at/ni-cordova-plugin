Replace MainActivity.java and correct package name
Copy PaymentCallBack.java to com.btpl.plugins.ni.NetworkInternational

Add below repositiories inside android/build.gradle:

    repositories {
        google()
        jcenter()
        maven { url 'https://jitpack.io' }
    }


Add below lines inside android/app/build.gradle:
    
    implementation 'com.github.network-international.payment-sdk-android:payment-sdk-core:1.0.0'

    // For card payment
    implementation 'com.github.network-international.payment-sdk-android:payment-sdk:1.0.0'    
