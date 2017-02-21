package com.github.maksadavid.recettesmamiemone.service;

import android.content.Context;

import com.github.maksadavid.recettesmamiemone.model.Recipe;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public interface RecipeService {

    /**
     * @param context
     * @return a list of Recipes, never null.
     * @throws Exception contains information about what went wrong.
     */
    ArrayList<Recipe> getAllRecipes(Context context) throws Exception;

}
