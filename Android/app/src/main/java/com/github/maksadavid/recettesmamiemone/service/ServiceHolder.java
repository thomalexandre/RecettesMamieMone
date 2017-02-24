package com.github.maksadavid.recettesmamiemone.service;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class ServiceHolder {

    public static final RecipeService recipeService = new RecipeServiceImpl();

    public static final ConfigurationService configurationService = new ConfigurationServiceImpl();
}
