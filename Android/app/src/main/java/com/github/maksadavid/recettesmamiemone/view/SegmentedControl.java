package com.github.maksadavid.recettesmamiemone.view;

import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.support.annotation.Nullable;
import android.support.annotation.RequiresApi;
import android.support.v4.content.ContextCompat;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.application.RMMApplication;
import com.github.maksadavid.recettesmamiemone.util.Fonts;

import java.util.ArrayList;
import java.util.Objects;

/**
 * Created by maksadavid on 2017. 03. 21..
 */

public class SegmentedControl extends LinearLayout implements Button.OnClickListener {

    private boolean singleSelection = true;
    private ArrayList<Object> activeTags = new ArrayList<>();
    private ArrayList<Object> previousActiveTags = new ArrayList<>();

    public SegmentedControl(Context context) {
        super(context);
    }

    public SegmentedControl(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init(context, attrs);
    }

    public SegmentedControl(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context, attrs);
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public SegmentedControl(Context context, @Nullable AttributeSet attrs, int defStyleAttr, int defStyleRes) {
        super(context, attrs, defStyleAttr, defStyleRes);
        init(context, attrs);
    }

    private void init (Context context, @Nullable AttributeSet attrs) {
        TypedArray a = context.getTheme().obtainStyledAttributes(attrs, R.styleable.SegmentedControl, 0, 0);
        try {
            singleSelection = a.getBoolean(R.styleable.SegmentedControl_singleSelection, true);
        } finally {
            a.recycle();
        }
    }

    public void addSegment(String title, @Nullable Drawable image, Object tag) {
        Button button = new Button(getContext());
        button.setBackgroundColor(Color.WHITE);
        button.setText(title);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(LinearLayout.LayoutParams.WRAP_CONTENT,
                LayoutParams.MATCH_PARENT, 1.0f);
        params.setMargins(5, 5, 5, 5);
        button.setLayoutParams(params);
        button.setTransformationMethod(null);
        button.setGravity(Gravity.CENTER);
        if (image != null) {
            image.setBounds(0, 0, 170, 170);
            button.setCompoundDrawables(null, image, null, null);
        }
        int padding = (int) getResources().getDimension(R.dimen.small_padding);
        button.setPadding(padding, padding, padding, padding);
        if (Build.VERSION.SDK_INT < 23) {
            button.setTextAppearance(getContext(), android.R.style.TextAppearance_Small);
        }
        else {
            button.setTextAppearance(android.R.style.TextAppearance_Small);
        }
        button.setTypeface(Fonts.OpenSansRegular);
        button.setOnClickListener(this);
        addView(button);
        button.setTag(tag);
        updateSegmentUI(button, false);
    }

    public ArrayList<Object> getActiveTags() {
        previousActiveTags = new ArrayList<>(activeTags);
        return activeTags;
    }

    public void restoreToPreviousState() {
        for (int i=0; i<getChildCount(); i++) {
            Button button = (Button) getChildAt(i);
            updateSegmentUI(button, previousActiveTags.contains(button.getTag()));
        }
        activeTags = new ArrayList<>(previousActiveTags);
    }

    private void updateSegmentUI(Button button, boolean active) {
        int colorText;
        int colorImage;
        if (active) {
            colorText = ContextCompat.getColor(RMMApplication.getAppContext(),R.color.colorRichBlack);
            colorImage = ContextCompat.getColor(RMMApplication.getAppContext(),R.color.colorPrimary);
        }
        else {
            colorText = Color.LTGRAY;
            colorImage = Color.LTGRAY;
        }
        Drawable image = button.getCompoundDrawables()[1];
        if (image != null) {
            image.setColorFilter(colorImage, PorterDuff.Mode.SRC_ATOP);
        }
        button.setTextColor(colorText);
    }

    @Override
    public void onClick(View v) {
        Object segmentId = v.getTag();
        if (activeTags.contains(segmentId)) {
            if (singleSelection) {
                activeTags = new ArrayList<>();
            }
            else {
                activeTags.remove(segmentId);
            }
        }
        else {
            if (singleSelection) {
                activeTags = new ArrayList<>();
                activeTags.add(segmentId);
            }
            else {
                activeTags.add(segmentId);
            }
        }
        for (int i=0; i<getChildCount(); i++) {
            Button button = (Button) getChildAt(i);
            updateSegmentUI(button, activeTags.contains(button.getTag()));
        }
    }
}
