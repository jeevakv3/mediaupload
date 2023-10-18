package com.example.mediaupload;

import androidx.multidex.MultiDex;
import io.flutter.app.FlutterApplication;

public class MultidexApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(android.content.Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}