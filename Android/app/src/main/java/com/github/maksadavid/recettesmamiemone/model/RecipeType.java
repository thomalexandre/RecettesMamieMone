package com.github.maksadavid.recettesmamiemone.model;

import com.google.firebase.database.DataSnapshot;

import java.io.Serializable;

/**
 * Created by maksadavid on 2017. 03. 07..
 */
public class RecipeType implements Serializable {
    private static DataSnapshot dataSnapshot;
    private String rawText;

    public static void setDataSnapshot(DataSnapshot dataSnapshot) {
        RecipeType.dataSnapshot = dataSnapshot;
    }

    public RecipeType(String text) {
        this.rawText = text;
    }

    @Override
    public String toString() {
        return (String) dataSnapshot.child(rawText).child("name").getValue();
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