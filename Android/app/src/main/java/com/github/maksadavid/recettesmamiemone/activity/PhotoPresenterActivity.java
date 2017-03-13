package com.github.maksadavid.recettesmamiemone.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.widget.ImageView;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;

/**
 * Created by maksadavid on 2017. 03. 02..
 */
public class PhotoPresenterActivity extends AppCompatActivity {

    public final static String ARG_RECIPE = "arg_recipe";
    public final static String ARG_PHOTO_PATH = "photo_path";

    private Recipe recipe;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_photo_presenter);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowHomeEnabled(true);

        ImageView imageView = (ImageView) findViewById(R.id.image_view);
        recipe = (Recipe) getIntent().getExtras().getSerializable(ARG_RECIPE);
        String photoPath = (String) getIntent().getExtras().getSerializable(ARG_PHOTO_PATH);

        assert (recipe != null);
        assert (photoPath != null);
        setTitle(recipe.getTitle());
        ServiceHolder.recipeService.loadImageForRecipe(this, recipe, imageView, photoPath);
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == android.R.id.home) {
            Intent intent = new Intent(this, RecipeDetailActivity.class);
            intent.putExtra(RecipeDetailActivity.ARG_RECIPE, recipe);
            NavUtils.navigateUpTo(this, intent);
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
