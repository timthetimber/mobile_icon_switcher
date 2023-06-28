package de.timthetimber.mobileiconswitcher;
import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import android.content.ComponentName;
import android.content.Context;
import android.content.pm.PackageManager;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;

import java.util.*;

public class MobileIconSwitcherPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private PackageManager packageManager;
    private ComponentName defaultComponent;
    private FlutterPluginBinding flutterPluginBinding;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        this.flutterPluginBinding = flutterPluginBinding;
        this.channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "app_icon_switcher");
        this.channel.setMethodCallHandler(this);
        this.packageManager = flutterPluginBinding.getApplicationContext().getPackageManager();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if(call.method.equals("defaultComponent")){
          String component = call.argument("component");
          defaultComponent = new ComponentName(flutterPluginBinding.getApplicationContext(), component);
          result.success(true);
          return;
        }

        if(defaultComponent == null){
          result.error("NO_ICON_OR_ALIAS", "No default component name was provided. (Please check the documentation and read it again.)", null);
        }

        if (call.method.equals("changeIcon")) {
            String iconName = call.argument("iconName");
            String iconActivityAlias = call.argument("iconActivityAlias");
            if (iconName != null && iconActivityAlias != null) {
                ComponentName newIconComponent = new ComponentName(flutterPluginBinding.getApplicationContext(), iconActivityAlias);
                if (iconName.equals("default")) {
                    enableComponent(defaultComponent);
                    disableComponents();
                } else {
                    disableComponents();
                    enableComponent(newIconComponent);
                }
                result.success(true);
            } else {
                result.error("NO_ICON_OR_ALIAS", "No icon name or activity alias was provided.", null);
            }
        } else {
            result.notImplemented();
        }
    }

    private void disableComponents() {
        for(ActivityInfo info : getAllRunningActivities(flutterPluginBinding.getApplicationContext())){
            ComponentName componentName = new ComponentName(flutterPluginBinding.getApplicationContext(), info.name);
            packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_DISABLED, PackageManager.DONT_KILL_APP);
        }
    }

    private void enableComponent(ComponentName componentName) {
        packageManager.setComponentEnabledSetting(componentName, PackageManager.COMPONENT_ENABLED_STATE_ENABLED, PackageManager.DONT_KILL_APP);
    }

    public static ArrayList<ActivityInfo> getAllRunningActivities(Context context) {
        try {
            PackageInfo pi = context.getPackageManager().getPackageInfo(
                    context.getPackageName(), PackageManager.GET_ACTIVITIES);

            return new ArrayList<>(Arrays.asList(pi.activities));

        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        channel = null;
    }

}