package com.github.maksadavid.recettesmamiemone.fragment;

import android.app.Activity;
import android.os.Bundle;
import android.support.design.widget.CollapsingToolbarLayout;
import android.support.design.widget.TabLayout;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableLayout;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.activity.RecipeDetailActivity;
import com.github.maksadavid.recettesmamiemone.activity.RecipeListActivity;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.github.maksadavid.recettesmamiemone.util.Callback;

/**
 * A fragment representing a single Recipe detail screen.
 * This fragment is either contained in a {@link RecipeListActivity}
 * in two-pane mode (on tablets) or a {@link RecipeDetailActivity}
 * on handsets.
 */
public class RecipeDetailFragment extends Fragment {

    public final static String ARG_RECIPE = "argRecipe";

    private Recipe recipe;
    private TextView ingredientsTextView;

    public RecipeDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(ARG_RECIPE)) {
            recipe = (Recipe) getArguments().getSerializable(ARG_RECIPE);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_recipe_detail, container, false);
        ingredientsTextView = (TextView) rootView.findViewById(R.id.recipe_detail);

        if (recipe != null) {
            ServiceHolder.recipeService.fetchDetailsForRecipe(recipe, new Callback<Recipe>() {
                @Override
                public void execute(Recipe result) {
                    RecipeDetailFragment.this.recipe = recipe;
                    RecipeDetailFragment.this.ingredientsTextView.setText(recipe.getType().toString() +
                            "\n\n" + recipe.getHardness().toString() +
                            "\n\n" + recipe.getIngredients() +
                            "\n\n" + recipe.getPreparation()
                    );
                }
            }, new Callback<Exception>() {
                @Override
                public void execute(Exception result) {

                }
            });
        }

        return rootView;
    }
}
