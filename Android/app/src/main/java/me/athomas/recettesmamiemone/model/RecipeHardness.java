package me.athomas.recettesmamiemone.model;

import com.google.firebase.database.DataSnapshot;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 03. 07..
 */

public class RecipeHardness implements Serializable {
    private static DataSnapshot dataSnapshot;
    private String rawText;

    public static void setDataSnapshot(DataSnapshot dataSnapshot) {
        RecipeHardness.dataSnapshot = dataSnapshot;
    }

    public static ArrayList<RecipeHardness> getAllHardnesses() {
        ArrayList<RecipeHardness> hardnesses = new ArrayList<>();
        if (dataSnapshot != null) {
            for (DataSnapshot child : dataSnapshot.getChildren()) {
                hardnesses.add(new RecipeHardness(child.getKey()));
            }
        }
        return hardnesses;
    }

    public RecipeHardness(String text) {
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

        RecipeHardness that = (RecipeHardness) o;

        return rawText.equals(that.rawText);

    }

    @Override
    public int hashCode() {
        return rawText.hashCode();
    }
}
