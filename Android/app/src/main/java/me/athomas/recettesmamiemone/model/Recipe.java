package me.athomas.recettesmamiemone.model;

import com.google.firebase.database.DataSnapshot;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class Recipe implements Serializable {

    private String id;
    private String title;
    private RecipeType type;
    private RecipeHardness hardness;
    private String persons;
    private String ingredients;
    private String preparation;
    private ArrayList<String> photoPaths;
    private boolean isLive; // false for recipes that are in development

    public Recipe(DataSnapshot recipeData) {
        this.id = recipeData.getKey();
        this.title = (String) recipeData.child("title").getValue();
        this.type = new RecipeType((String) recipeData.child("type").getValue());
        this.hardness = new RecipeHardness((String) recipeData.child("hardness").getValue());
        this.persons = (String) recipeData.child("persons").getValue();
        this.isLive = (boolean) recipeData.child("live").getValue();
    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public RecipeType getType() {
        return type;
    }

    public RecipeHardness getHardness() {
        return hardness;
    }

    public String getPersons() {
        return persons;
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

    public ArrayList<String> getPhotoPaths() {
        return photoPaths;
    }

    public void setPhotoPaths(ArrayList<String> photoPaths) {
        this.photoPaths = photoPaths;
    }

    public boolean isLive() {
        return isLive;
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
