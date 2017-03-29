package com.github.maksadavid.recettesmamiemone.activity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.crashlytics.android.Crashlytics;
import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.fragment.RecipeFilterFragment;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.model.RecipeFilter;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.github.maksadavid.recettesmamiemone.util.Callback;
import com.github.maksadavid.recettesmamiemone.util.Fonts;
import com.github.maksadavid.recettesmamiemone.viewholder.RecipeViewHolder;
import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GoogleApiAvailability;
import com.google.android.gms.common.GooglePlayServicesUtil;

import org.w3c.dom.Text;

import java.util.ArrayList;

import io.fabric.sdk.android.Fabric;

/**
 * An activity representing a list of Recipes. This activity
 * has different presentations for handset and tablet-size devices. On
 * handsets, the activity presents a list of items, which when touched,
 * lead to a {@link RecipeDetailActivity} representing
 * item details. On tablets, the activity presents the list of items and
 * item details side-by-side using two vertical panes.
 */
public class RecipeListActivity extends AppCompatActivity implements RecipeFiltering {

    private static final Boolean showsOnlyLiveRecipes = true;

    private RecyclerView recyclerView;
    private RecipeFilter recipeFilter;
    private DrawerLayout drawerLayout;
    private ImageView filterImageView;
    private RecipeFilterFragment filterFragment;
    private TextView emptyAwareTextView;

    @Override
    public void setFilter(RecipeFilter filter) {
        this.recipeFilter = filter;
        updateRecipes();
        if (drawerLayout.isDrawerOpen(GravityCompat.END)) {
            drawerLayout.closeDrawer(GravityCompat.END);
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Fabric.with(this, new Crashlytics());
        setContentView(R.layout.activity_recipe_list);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerLayout.addDrawerListener(new DrawerLayout.DrawerListener() {
            @Override
            public void onDrawerSlide(View drawerView, float slideOffset) {

            }

            @Override
            public void onDrawerOpened(View drawerView) {
                updateFilterImageState();
            }

            @Override
            public void onDrawerClosed(View drawerView) {
                updateFilterImageState();
                filterFragment.restoreToPreviousState();
            }

            @Override
            public void onDrawerStateChanged(int newState) {

            }
        });
        filterImageView = (ImageView) toolbar.findViewById(R.id.filter_image_view);
        filterImageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (drawerLayout.isDrawerOpen(GravityCompat.END)) {
                    drawerLayout.closeDrawer(GravityCompat.END);
                }
                else {
                    drawerLayout.openDrawer(GravityCompat.END);
                }
                updateFilterImageState();
            }
        });
        recyclerView = (RecyclerView) findViewById(R.id.recipe_list);
        recyclerView.setLayoutManager(new GridLayoutManager(this, getResources().getInteger(R.integer.recipe_list_column_count)));
        emptyAwareTextView = (TextView) findViewById(R.id.empty_aware_text_view);
        emptyAwareTextView.setTypeface(Fonts.OpenSansBold);

        filterFragment = new RecipeFilterFragment();
        getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.right_drawer, filterFragment)
                .commit();
        updateRecipes();
    }

    @Override
    protected void onResume() {
        super.onResume();
        int code = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(this);
        if (code != ConnectionResult.SUCCESS) {
            GooglePlayServicesUtil.showErrorDialogFragment(code, this, null, 0, new DialogInterface.OnCancelListener() {
                @Override
                public void onCancel(DialogInterface dialog) {

                }
            });
        }

        updateFilterImageState();
    }

    private void updateRecipes() {
        ServiceHolder.recipeService.getAllRecipes(new Callback<ArrayList<Recipe>>() {
            @Override
            public void execute(ArrayList<Recipe> result) {
                if (recipeFilter != null) {
                    result = recipeFilter.filterRecipes(result);
                }
                if (showsOnlyLiveRecipes) {
                    result = RecipeFilter.filterRecipesForLive(result);
                }
                emptyAwareTextView.setVisibility(result.size() == 0 ? View.VISIBLE : View.GONE);
                recyclerView.setAdapter(new SimpleItemRecyclerViewAdapter(result));
                if (recipeFilter == null) {
                    filterFragment.updateFilterOptions();
                }
            }
        }, new Callback<Exception>() {
            @Override
            public void execute(Exception result) {

            }
        });
    }

    private void updateFilterImageState() {
        if (drawerLayout.isDrawerOpen(GravityCompat.END)) {
            filterImageView.setImageDrawable(ContextCompat.getDrawable(RecipeListActivity.this, R.drawable.ic_menu_close));
        }
        else {
            filterImageView.setImageDrawable(ContextCompat.getDrawable(RecipeListActivity.this, R.drawable.ic_menu_filter));
        }
    }

    public class SimpleItemRecyclerViewAdapter extends RecyclerView.Adapter<RecipeViewHolder> {

        private final ArrayList<Recipe> recipes;

        public SimpleItemRecyclerViewAdapter(ArrayList<Recipe> recipes) {
            this.recipes = recipes;
        }

        @Override
        public RecipeViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.item_recipe, parent, false);
            return new RecipeViewHolder(view);
        }

        @Override
        public void onBindViewHolder(final RecipeViewHolder holder, int position) {
            final Recipe recipe = recipes.get(position);
            holder.titleTextView.setText(recipe.getTitle());
            ServiceHolder.recipeService.loadImageForRecipe(RecipeListActivity.this, recipe, holder.imageView, null);
            holder.view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Context context = v.getContext();
                    Intent intent = new Intent(context, RecipeDetailActivity.class);
                    intent.putExtra(RecipeDetailActivity.ARG_RECIPE, recipe);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        public int getItemCount() {
            return recipes.size();
        }

    }

}
