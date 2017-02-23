package com.github.maksadavid.recettesmamiemone.service;

import android.content.Context;
import android.widget.ImageView;

import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.util.Callback;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public interface RecipeService {

    void getAllRecipes(Callback<ArrayList<Recipe>> success, Callback<Exception> failure);

    void fetchDetailsForRecipe(Recipe recipe, Callback<Recipe> success, Callback<Exception> failure);

    void loadImageForRecipe(Context context, Recipe recipe, ImageView imageView);

}
