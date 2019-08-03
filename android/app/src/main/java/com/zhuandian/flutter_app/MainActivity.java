package com.zhuandian.flutter_app;

import android.os.Bundle;
import android.text.TextUtils;

import com.zhuandian.flutter_app.util.Constant;

import java.util.ArrayList;
import java.util.List;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String MESSAGE_CHANNEL = "zhuandian.flutter";

    private String userObjectId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

//        userObjectId = getIntent().getStringExtra("userObjectId");
        userObjectId ="NXPhgdOZ";

        initMessageChannl();
    }


    private void initMessageChannl() {
        new MethodChannel(getFlutterView(), MESSAGE_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (methodCall.method.equals("getAppConfig")) {
                    List<String> configs = new ArrayList<>();
                    configs.add(Constant.APPID);
                    configs.add(Constant.API_KEY);
                    result.success(configs);
                } else if (methodCall.method.equals("getUserObjectId")) {
                    if (!TextUtils.isEmpty(userObjectId)) {
                        result.success(userObjectId);
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }
}
