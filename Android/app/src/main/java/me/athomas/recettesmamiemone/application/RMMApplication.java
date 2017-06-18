package me.athomas.recettesmamiemone.application;

import android.app.Application;
import android.content.Context;

import com.google.firebase.database.FirebaseDatabase;

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
