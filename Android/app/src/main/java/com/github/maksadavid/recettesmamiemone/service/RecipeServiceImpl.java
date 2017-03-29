package com.github.maksadavid.recettesmamiemone.service;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.load.resource.drawable.GlideDrawable;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.Target;
import com.firebase.ui.storage.images.FirebaseImageLoader;
import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.application.RMMApplication;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.model.RecipeHardness;
import com.github.maksadavid.recettesmamiemone.model.RecipeType;
import com.github.maksadavid.recettesmamiemone.util.Callback;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageException;
import com.google.firebase.storage.StorageMetadata;
import com.google.firebase.storage.StorageReference;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class RecipeServiceImpl implements RecipeService {

    private DatabaseReference recipesDbRef;
    private DatabaseReference recipeDetailsDbRef;
    private StorageReference recipeImageStorageRef;

    public RecipeServiceImpl() {
        this.recipesDbRef = FirebaseDatabase.getInstance().getReference("recipes");
        this.recipeDetailsDbRef = FirebaseDatabase.getInstance().getReference("details");
        this.recipeImageStorageRef = FirebaseStorage.getInstance().getReferenceFromUrl("gs://recettesmamie-d0853.appspot.com");
    }

    @Override
    public void getAllRecipes(final Callback<ArrayList<Recipe>> success, final Callback<Exception> failure) {
        recipesDbRef.addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                RecipeType.setDataSnapshot(dataSnapshot.child("types"));
                RecipeHardness.setDataSnapshot(dataSnapshot.child("hardnesses"));
                ArrayList<Recipe> newRecipes = new ArrayList<>();
                for (DataSnapshot recipeData : dataSnapshot.child("list").getChildren()) {
                    newRecipes.add(new Recipe(recipeData));
                }
                Collections.sort(newRecipes, new RecipeComparator());
                success.execute(newRecipes);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                failure.execute(new Exception("getAllRecipes was cancelled"));
            }
        });
    }

    @Override
    public void fetchDetailsForRecipe(final Recipe recipe, final Callback<Recipe> success, final Callback<Exception> failure) {
        recipeDetailsDbRef.child(recipe.getId()).addValueEventListener(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                recipe.setIngredients((String) dataSnapshot.child("ingredients").getValue());
                recipe.setPreparation((String) dataSnapshot.child("preparation").getValue());
                ArrayList<String> photoPaths = new ArrayList<>();
                if (dataSnapshot.child("photos").getValue() instanceof ArrayList) {
                    for (Map photoData : (ArrayList<Map>) dataSnapshot.child("photos").getValue()) {
                        photoPaths.add((String) photoData.get("filename"));
                    }
                }
                recipe.setPhotoPaths(photoPaths);
                success.execute(recipe);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                failure.execute(new Exception("fetchDetailsForRecipe was cancelled"));
            }
        });
    }

    @Override
    public void loadImageForRecipe(Context context, Recipe recipe, final ImageView imageView, String path) {
        if (path == null) {
            path = "thumbnail.jpg";
        }

        StorageReference storageReference = recipeImageStorageRef.child(recipe.getId()).child(path);
        Glide.with(imageView.getContext())
                .using(new FirebaseImageLoader())
                .load(storageReference)
                .listener(new RequestListener<StorageReference, GlideDrawable>() {
                    @Override
                    public boolean onException(Exception e, StorageReference model, Target<GlideDrawable> target, boolean isFirstResource) {
                        imageView.setBackgroundColor(Color.WHITE);
                        return false;
                    }

                    @Override
                    public boolean onResourceReady(GlideDrawable resource, StorageReference model, Target<GlideDrawable> target, boolean isFromMemoryCache, boolean isFirstResource) {
                        imageView.setBackgroundColor(Color.BLACK);
                        return false;
                    }
                })
                .error(R.drawable.placeholder)
                .into(imageView);
    }

    public class RecipeComparator implements Comparator<Recipe> {
        public int compare(Recipe recipe1, Recipe recipe2) {

            int compareType = recipe1.getType().getRawText().compareTo(recipe2.getType().getRawText());
            if(compareType != 0) {
                return compareType;
            }

            return recipe1.getTitle().compareTo(recipe2.getTitle());
        }
    }

}
