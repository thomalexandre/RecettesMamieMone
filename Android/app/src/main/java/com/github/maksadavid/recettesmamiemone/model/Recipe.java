package com.github.maksadavid.recettesmamiemone.model;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class Recipe {

    public enum Type {
        TYPE0, TYPE1, TYPE2
    }

    public enum Hardness {
        HARDNESS0, HARDNESS1, HARDNESS2
    }

    private String title;
    private Type type;
    private Hardness hardness;

    public Recipe(String title, Type type, Hardness hardness) {
        this.title = title;
        this.type = type;
        this.hardness = hardness;
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
