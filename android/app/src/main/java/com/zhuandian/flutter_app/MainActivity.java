package com.zhuandian.flutter_app;

import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Toast;

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
        userObjectId = "NXPhgdOZ";

        initMessageChannl();
    }


    private void initMessageChannl() {
        new MethodChannel(getFlutterView(), MESSAGE_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                if (Constant.GET_APP_CONFIG.equals(methodCall.method)) {
                    List<String> configs = new ArrayList<>();
                    configs.add(Constant.APPID);
                    configs.add(Constant.API_KEY);
                    result.success(configs);
                } else if (Constant.GET_USER_OBJECT_ID.equals(methodCall.method)) {
                    if (!TextUtils.isEmpty(userObjectId)) {
                        result.success(userObjectId);
                    }
                } else if (Constant.OPEN_CHAT.equals(methodCall.method)) {
                    if (methodCall.hasArgument(Constant.KEY_RELREASE_USER_ID) && !TextUtils.isEmpty(methodCall.argument(Constant.KEY_RELREASE_USER_ID))) {
                        String releaseUserId = methodCall.argument(Constant.KEY_RELREASE_USER_ID);
                        Toast.makeText(MainActivity.this, "唤起原生聊天成功" + releaseUserId, Toast.LENGTH_SHORT).show();
                    }
                } else if (Constant.VIEW_USER_INFO.equals(methodCall.method)) {
                    if (methodCall.hasArgument(Constant.KEY_RELREASE_USER_ID) && !TextUtils.isEmpty(methodCall.argument(Constant.KEY_RELREASE_USER_ID))) {
                        String releaseUserId = methodCall.argument(Constant.KEY_RELREASE_USER_ID);
                        Toast.makeText(MainActivity.this, "唤起原生查看资料成功" + releaseUserId, Toast.LENGTH_SHORT).show();
                    }
                } else {
                    result.notImplemented();
                }
            }
        });
    }
}
