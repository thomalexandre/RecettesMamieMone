package com.github.maksadavid.recettesmamiemone.model;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 03. 11..
 */
public class RecipeFilter {

    private ArrayList<RecipeType> validTypes;
    private ArrayList<RecipeHardness> validHardnesses;

    public RecipeFilter(ArrayList<RecipeType> validTypes, ArrayList<RecipeHardness> validHardnesses) {
        this.validTypes = validTypes;
        this.validHardnesses = validHardnesses;
    }

    public ArrayList<Recipe> filterRecipes(ArrayList<Recipe> recipes) {

        ArrayList<Recipe> filteredRecipes = new ArrayList<>();

        boolean showAllTypes = validTypes.isEmpty();
        boolean showAllHardnesses = validHardnesses.isEmpty();

        for (Recipe recipe : recipes) {
            if ((validTypes.contains(recipe.getType()) || showAllTypes) && (validHardnesses.contains(recipe.getHardness()) || showAllHardnesses)){
                filteredRecipes.add(recipe);
            }
        }
        return filteredRecipes;
    }

    static public ArrayList<Recipe> filterRecipesForLive(ArrayList<Recipe> recipes) {
        ArrayList<Recipe> filteredRecipes = new ArrayList<>();
        for (Recipe recipe : recipes) {
            if (recipe.isLive()){
                filteredRecipes.add(recipe);
            }
        }
        return filteredRecipes;
    }
}
