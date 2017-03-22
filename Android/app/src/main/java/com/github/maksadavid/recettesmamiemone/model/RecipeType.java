package com.github.maksadavid.recettesmamiemone.model;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Build;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.application.RMMApplication;
import com.google.firebase.database.DataSnapshot;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 03. 07..
 */
public class RecipeType implements Serializable {
    private static DataSnapshot dataSnapshot;
    private String rawText;

    public static void setDataSnapshot(DataSnapshot dataSnapshot) {
        RecipeType.dataSnapshot = dataSnapshot;
    }

    public static ArrayList<RecipeType> getAllTypes() {
        ArrayList<RecipeType> types = new ArrayList<>();
        if (dataSnapshot != null) {

            for (DataSnapshot child : dataSnapshot.getChildren()) {
                types.add(new RecipeType(child.getKey()));
            }
        }
        return types;
    }

    RecipeType(String text) {
        this.rawText = text;
    }

    public String getRawText() {
        return rawText;
    }

    @Override
    public String toString() {
        return (String) dataSnapshot.child(rawText).child("name").getValue();
    }

    public Drawable getDrawable() {
        String drawableName = (String) dataSnapshot.child(rawText).child("image").getValue();
        drawableName = drawableName.replace("-", "_");
        Context context = RMMApplication.getAppContext();
        int drawableResourceId = context.getResources().getIdentifier(drawableName, "drawable", context.getPackageName());
        if (drawableResourceId == 0) {
            drawableResourceId = R.drawable.placeholder;
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            return context.getDrawable(drawableResourceId);
        }
        else {
            return context.getResources().getDrawable(drawableResourceId);
        }
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RecipeType that = (RecipeType) o;

        return rawText.equals(that.rawText);

    }

    @Override
    public int hashCode() {
        return rawText.hashCode();
    }
}