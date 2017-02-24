package com.github.maksadavid.recettesmamiemone.model;

import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.google.firebase.database.DataSnapshot;

import java.io.Serializable;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class Recipe implements Serializable {

    public enum Type {
        TYPE0("type_0"), TYPE1("type_1"), TYPE2("type_2");
        private static DataSnapshot dataSnapshot;
        private String rawText;

        public static void setDataSnapshot(DataSnapshot dataSnapshot) {
            Type.dataSnapshot = dataSnapshot;
        }
        public static Type fromString(String text) {
            for (Type t : Type.values()) {
                if (t.rawText.equalsIgnoreCase(text)) {
                    return t;
                }
            }
            return null;
        }

        Type(String text) {
            this.rawText = text;
        }

        @Override
        public String toString() {
            return (String) dataSnapshot.child(rawText).child("name").getValue();
        }
    }

    public enum Hardness {
        HARDNESS0("hardness_0"), HARDNESS1("hardness_1"), HARDNESS2("hardness_2");
        private static DataSnapshot dataSnapshot;
        private String rawText;

        public static void setDataSnapshot(DataSnapshot dataSnapshot) {
            Hardness.dataSnapshot = dataSnapshot;
        }

        public static Hardness fromString(String text) {
            for (Hardness t : Hardness.values()) {
                if (t.rawText.equalsIgnoreCase(text)) {
                    return t;
                }
            }
            return null;
        }

        Hardness(String text) {
            this.rawText = text;
        }

        @Override
        public String toString() {
            return (String) dataSnapshot.child(rawText).child("name").getValue();
        }
    }

    private String id;
    private String title;
    private Type type;
    private Hardness hardness;
    private String ingredients;
    private String preparation;

    public Recipe(DataSnapshot recipeData) {
        this.id = recipeData.getKey();
        this.title = (String) recipeData.child("title").getValue();
        this.type = Type.fromString((String) recipeData.child("type").getValue());
        this.hardness = Hardness.fromString((String) recipeData.child("hardness").getValue());
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public Type getType() {
        return type;
    }

    public Hardness getHardness() {
        return hardness;
    }

    public String getIngredients() {
        return ingredients;
    }

    public void setIngredients(String ingredients) {
        this.ingredients = ingredients;
    }

    public String getPreparation() {
        return preparation;
    }

    public void setPreparation(String preparation) {
        this.preparation = preparation;
    }

    @Override
    public String toString() {
        return "Recipe{" +
                "title='" + title + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Recipe recipe = (Recipe) o;

        return title != null ? title.equals(recipe.title) : recipe.title == null;

    }

    @Override
    public int hashCode() {
        return title != null ? title.hashCode() : 0;
    }
}
