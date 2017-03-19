package com.github.maksadavid.recettesmamiemone.util;

import android.graphics.Typeface;

import com.github.maksadavid.recettesmamiemone.application.RMMApplication;

/**
 * Created by maksadavid on 2017. 03. 02..
 */
public class Fonts {

    // For ingredients and preparation text
    public static final Typeface MerriweatherRegular = Typeface.createFromAsset(RMMApplication.getAppContext().getAssets(),
            "fonts/Merriweather/Merriweather-Regular.ttf");

    // Home page card titles
    public static final Typeface OpenSansRegular = Typeface.createFromAsset(RMMApplication.getAppContext().getAssets(),
            "fonts/Open_Sans/OpenSans-Regular.ttf");

    // Toolbar title (action bar), other titles
    public static final Typeface OpenSansBold = Typeface.createFromAsset(RMMApplication.getAppContext().getAssets(),
            "fonts/Open_Sans/OpenSans-Bold.ttf");
}
