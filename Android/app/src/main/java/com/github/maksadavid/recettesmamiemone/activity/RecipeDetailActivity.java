package com.github.maksadavid.recettesmamiemone.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.fragment.PhotoCarouselFragment;
import com.github.maksadavid.recettesmamiemone.fragment.RecipeDetailFragment;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.github.maksadavid.recettesmamiemone.util.Callback;
import com.github.maksadavid.recettesmamiemone.util.Fonts;

/**
 * An activity representing a single Recipe detail screen. This
 * activity is only used narrow width devices. On tablet-size devices,
 * item details are presented side-by-side with a list of items
 * in a {@link RecipeListActivity}.
 */

public class RecipeDetailActivity extends AppCompatActivity {

    public final static String ARG_RECIPE = "argRecipe";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_detail);
        Toolbar toolbar = (Toolbar) findViewById(R.id.detail_toolbar);
        setSupportActionBar(toolbar);

        ImageView headerImageView = (ImageView) findViewById(R.id.header_image_view);
        TextView headerTextView = (TextView) findViewById(R.id.header_text_view);
        headerTextView.setTypeface(Fonts.OpenSansRegular);

        if (getIntent().getExtras().containsKey(ARG_RECIPE)) {
            Recipe recipe = (Recipe) getIntent().getExtras().getSerializable(ARG_RECIPE);
            ServiceHolder.recipeService.loadImageForRecipe(this, recipe, headerImageView, null);
            CollapsingToolbarLayout appBarLayout = (CollapsingToolbarLayout) findViewById(R.id.toolbar_layout);
            appBarLayout.setTitle(recipe.getTitle());
            headerTextView.setText(recipe.getType().toString() + " - " + recipe.getHardness().toString() + " - " + recipe.getPersons());
        }

        // Show the Up button in the action bar.
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.setDisplayHomeAsUpEnabled(true);
        }

        final Recipe recipe = (Recipe) getIntent().getExtras().getSerializable(ARG_RECIPE);
        if (savedInstanceState == null && recipe != null) {

            ServiceHolder.recipeService.fetchDetailsForRecipe(recipe, new Callback<Recipe>() {
                @Override
                public void execute(Recipe result) {

                    Bundle arguments = new Bundle();
                    arguments.putSerializable(ARG_RECIPE, recipe);

                    Fragment fragment = new RecipeDetailFragment();
                    fragment.setArguments(arguments);
                    getSupportFragmentManager().beginTransaction()
                            .add(R.id.ingredients_fragment, fragment)
                            .commit();

                    if (recipe.getPhotoPaths().size() > 0) {
                        Fragment photoCarouselFragment = new PhotoCarouselFragment();
                        photoCarouselFragment.setArguments(arguments);
                        getSupportFragmentManager().beginTransaction()
                                .add(R.id.photos_fragment, photoCarouselFragment)
                                .commit();
                    }
                }
            }, new Callback<Exception>() {
                @Override
                public void execute(Exception result) {

                }
            });

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
