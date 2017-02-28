package com.github.maksadavid.recettesmamiemone.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.widget.ImageView;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.fragment.RecipeDetailFragment;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;

/**
 * An activity representing a single Recipe detail screen. This
 * activity is only used narrow width devices. On tablet-size devices,
 * item details are presented side-by-side with a list of items
 * in a {@link RecipeListActivity}.
 */

public class RecipeDetailActivity extends AppCompatActivity {

    private ImageView headerImageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_detail);
        Toolbar toolbar = (Toolbar) findViewById(R.id.detail_toolbar);
        setSupportActionBar(toolbar);

        headerImageView = (ImageView) findViewById(R.id.header_image_view);

        if (getIntent().getExtras().containsKey(RecipeDetailFragment.ARG_RECIPE)) {
            Recipe recipe = (Recipe) getIntent().getExtras().getSerializable(RecipeDetailFragment.ARG_RECIPE);
            ServiceHolder.recipeService.loadImageForRecipe(this, recipe, headerImageView);
        }

        // Show the Up button in the action bar.
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }

        if (savedInstanceState == null) {
            // Create the detail fragment and add it to the activity
            // using a fragment transaction.
            RecipeDetailFragment fragment = new RecipeDetailFragment();
            fragment.setArguments(getIntent().getExtras());
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.recipe_detail_container, fragment)
                    .commit();
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == android.R.id.home) {
            NavUtils.navigateUpTo(this, new Intent(this, RecipeListActivity.class));
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
}
