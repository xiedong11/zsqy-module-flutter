package com.zhuandian.flutter_app;

import android.content.Intent;
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
    private boolean isVisitor;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

//        userObjectId = getIntent().getStringExtra("userObjectId");
        isVisitor = getIntent().getBooleanExtra("isVisitor", false);
        userObjectId = "NXPhgdOZ";

        initMessageChannl();
    }


    private void initMessageChannl() {
        new MethodChannel(getFlutterView(), MESSAGE_CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {

                switch (methodCall.method) {
                    case Constant.GET_APP_CONFIG:
                        List<String> configs = new ArrayList<>();
                        configs.add(Constant.APPID);
                        configs.add(Constant.API_KEY);
                        result.success(configs);
                        break;
                    case Constant.GET_USER_OBJECT_ID:
                        if (!TextUtils.isEmpty(userObjectId)) {
                            result.success(userObjectId);
                        }
                        break;
                    case Constant.OPEN_CHAT:
                        if (methodCall.hasArgument(Constant.KEY_RELREASE_USER_ID) && !TextUtils.isEmpty(methodCall.argument(Constant.KEY_RELREASE_USER_ID))) {
                            String releaseUserId = methodCall.argument(Constant.KEY_RELREASE_USER_ID);
                            Intent intent = new Intent();
                            intent.setAction("com.zhuandian.flutterbridge");
                            intent.putExtra(Constant.NATIVE_PAGE_TYPE, Constant.CHAT_PAGE);
                            intent.putExtra(Constant.KEY_RELREASE_USER_ID, releaseUserId);
                            startActivity(intent);
                        }
                        break;
                    case Constant.VIEW_USER_INFO:
                        if (methodCall.hasArgument(Constant.KEY_RELREASE_USER_ID) && !TextUtils.isEmpty(methodCall.argument(Constant.KEY_RELREASE_USER_ID))) {
                            String releaseUserId = methodCall.argument(Constant.KEY_RELREASE_USER_ID);
                            Intent intent = new Intent();
                            intent.setAction("com.zhuandian.flutterbridge");
                            intent.putExtra(Constant.NATIVE_PAGE_TYPE, Constant.USER_INFO_DETAIL);
                            intent.putExtra(Constant.KEY_RELREASE_USER_ID, releaseUserId);
                            startActivity(intent);
                        }
                        break;
                    case Constant.IS_VISITOR:
                        result.success(isVisitor);
                        break;
                    default:
                        result.notImplemented();
                }
            }
        });
    }
}
