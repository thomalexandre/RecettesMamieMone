package com.github.maksadavid.recettesmamiemone.service;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class ServiceHolder {

    public static final String RECIPES_UPDATE_ACTION = "com.github.maksadavid.recettesmamiemome.RECIPES_UPDATE";

    public static final RecipeService recipeService = new RecipeServiceImpl();

}
