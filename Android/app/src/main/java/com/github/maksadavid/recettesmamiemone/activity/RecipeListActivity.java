package com.github.maksadavid.recettesmamiemone.activity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.fragment.RecipeDetailFragment;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.github.maksadavid.recettesmamiemone.util.Callback;
import com.github.maksadavid.recettesmamiemone.viewholder.RecipeViewHolder;

import java.util.ArrayList;

/**
 * An activity representing a list of Recipes. This activity
 * has different presentations for handset and tablet-size devices. On
 * handsets, the activity presents a list of items, which when touched,
 * lead to a {@link RecipeDetailActivity} representing
 * item details. On tablets, the activity presents the list of items and
 * item details side-by-side using two vertical panes.
 */
public class RecipeListActivity extends AppCompatActivity {

    /**
     * Whether or not the activity is in two-pane mode, i.e. running on a tablet
     * device.
     */
    private boolean mTwoPane;
    private RecyclerView recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recipe_list);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        toolbar.setTitle(getTitle());

        recyclerView = (RecyclerView) findViewById(R.id.recipe_list);
        assert recyclerView != null;
        updateRecipes();
        if (findViewById(R.id.recipe_detail_container) != null) {
            mTwoPane = true;
        }
    }

    private void updateRecipes() {
        ServiceHolder.recipeService.getAllRecipes(new Callback<ArrayList<Recipe>>() {
            @Override
            public void execute(ArrayList<Recipe> result) {
                recyclerView.setAdapter(new SimpleItemRecyclerViewAdapter(result));
            }
        }, new Callback<Exception>() {
            @Override
            public void execute(Exception result) {

            }
        });
    }

    public class SimpleItemRecyclerViewAdapter extends RecyclerView.Adapter<RecipeViewHolder> {

        private final ArrayList<Recipe> recipes;

        public SimpleItemRecyclerViewAdapter(ArrayList<Recipe> recipes) {
            this.recipes = recipes;
        }

        @Override
        public RecipeViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.recipe_list_content, parent, false);
            return new RecipeViewHolder(view);
        }

        @Override
        public void onBindViewHolder(final RecipeViewHolder holder, int position) {
            final Recipe recipe = recipes.get(position);
            holder.titleTextView.setText(recipe.getTitle());
            ServiceHolder.recipeService.loadImageForRecipe(RecipeListActivity.this, recipe, holder.imageView);
            holder.view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if (mTwoPane) {
                        Bundle arguments = new Bundle();
                        arguments.putSerializable(RecipeDetailFragment.ARG_RECIPE, recipe);
                        RecipeDetailFragment fragment = new RecipeDetailFragment();
                        fragment.setArguments(arguments);
                        getSupportFragmentManager().beginTransaction()
                                .replace(R.id.recipe_detail_container, fragment)
                                .commit();
                    } else {
                        Context context = v.getContext();
                        Intent intent = new Intent(context, RecipeDetailActivity.class);
                        intent.putExtra(RecipeDetailFragment.ARG_RECIPE, recipe);
                        context.startActivity(intent);
                    }
                }
            });
        }

        @Override
        public int getItemCount() {
            return recipes.size();
        }


    }
}
