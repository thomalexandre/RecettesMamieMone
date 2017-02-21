package com.github.maksadavid.recettesmamiemone.service;

import android.content.Context;

import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;


/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class RecipeServiceImpl implements RecipeService, ValueEventListener {

    private DatabaseReference recipesDbRef;
    private ArrayList<Recipe> recipes;

    public RecipeServiceImpl() {
        this.recipesDbRef = FirebaseDatabase.getInstance().getReference("recipes").child("list");
        recipesDbRef.addValueEventListener(this);
    }

    @Override
    public ArrayList<Recipe> getAllRecipes(Context context) throws Exception {
        ArrayList<Recipe> recipes = new ArrayList<>();
        for (int i=0 ; i<10; i++) {
            recipes.add(new Recipe("Recipe " + i, Recipe.Type.TYPE0, Recipe.Hardness.HARDNESS0));
        }
        return recipes;
    }

    @Override
    public void onDataChange(DataSnapshot dataSnapshot) {
        ArrayList<Recipe> newRecipes = new ArrayList<>();
        for (DataSnapshot recipeData : dataSnapshot.getChildren()) {
            newRecipes.add(new Recipe((String) recipeData.child("title").getValue(),
                    Recipe.Type.TYPE0,
                    Recipe.Hardness.HARDNESS0));
        }
        recipes = newRecipes;
    }

    @Override
    public void onCancelled(DatabaseError databaseError) {

    }
}
