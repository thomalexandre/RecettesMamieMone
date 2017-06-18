package me.athomas.recettesmamiemone.service;

import android.content.Context;
import android.support.annotation.Nullable;
import android.widget.ImageView;

import me.athomas.recettesmamiemone.model.Recipe;
import me.athomas.recettesmamiemone.util.Callback;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public interface RecipeService {

    void getAllRecipes(Callback<ArrayList<Recipe>> success, Callback<Exception> failure);

    void fetchDetailsForRecipe(Recipe recipe, Callback<Recipe> success, Callback<Exception> failure);

    void loadImageForRecipe(Context context, Recipe recipe, ImageView imageView, @Nullable String path);

}
