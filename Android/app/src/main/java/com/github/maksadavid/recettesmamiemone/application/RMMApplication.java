package com.github.maksadavid.recettesmamiemone.application;

import android.app.Application;
import android.content.Context;

/**
 * Created by maksadavid on 2017. 02. 22..
 */
public class RMMApplication extends Application {

    private static Context mContext;

    public void onCreate() {
        super.onCreate();
        mContext = getApplicationContext();
    }

    public static Context getAppContext() {
        return mContext;
    }

}
