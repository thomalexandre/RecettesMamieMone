package me.athomas.recettesmamiemone.fragment;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import me.athomas.recettesmamiemone.R;
import me.athomas.recettesmamiemone.activity.RecipeDetailActivity;
import me.athomas.recettesmamiemone.activity.RecipeListActivity;
import me.athomas.recettesmamiemone.model.Recipe;
import me.athomas.recettesmamiemone.util.Fonts;

/**
 * A fragment representing a single Recipe detail screen.
 * This fragment is either contained in a {@link RecipeListActivity}
 * in two-pane mode (on tablets) or a {@link RecipeDetailActivity}
 * on handsets.
 */
public class RecipeDetailFragment extends Fragment {

    private Recipe recipe;

    public RecipeDetailFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments().containsKey(RecipeDetailActivity.ARG_RECIPE)) {
            recipe = (Recipe) getArguments().getSerializable(RecipeDetailActivity.ARG_RECIPE);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_recipe_detail, container, false);

        TextView ingredientsTextView = (TextView) rootView.findViewById(R.id.ingredients_text_view);
        TextView preparationTextView = (TextView) rootView.findViewById(R.id.preparation_text_view);
        ingredientsTextView.setTypeface(Fonts.MerriweatherRegular);
        preparationTextView.setTypeface(Fonts.MerriweatherRegular);

        TextView preparationTitle = ((TextView)rootView.findViewById(R.id.preparation_title_text_view));
        preparationTitle.setTypeface(Fonts.OpenSansBold);

        TextView ingredientTitle = ((TextView)rootView.findViewById(R.id.ingredients_title_text_view));
        ingredientTitle.setTypeface(Fonts.OpenSansBold);

        if (recipe != null) {
            ingredientsTextView.setText(recipe.getIngredients());
            preparationTextView.setText(recipe.getPreparation());
        }

        return rootView;
    }
}
