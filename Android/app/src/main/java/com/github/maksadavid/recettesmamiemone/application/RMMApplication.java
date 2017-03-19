package com.github.maksadavid.recettesmamiemone.application;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.os.Bundle;

import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.storage.FirebaseStorage;

/**
 * Created by maksadavid on 2017. 02. 22..
 */
public class RMMApplication extends Application {

    private static Context mContext;

    public void onCreate() {
        super.onCreate();

        FirebaseDatabase.getInstance().setPersistenceEnabled(true);

        mContext = getApplicationContext();
    }

    public static Context getAppContext() {
        return mContext;
    }

}
