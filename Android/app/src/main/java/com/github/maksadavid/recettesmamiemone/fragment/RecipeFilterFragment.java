package com.github.maksadavid.recettesmamiemone.fragment;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.BuildConfig;
import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.activity.RecipeFiltering;
import com.github.maksadavid.recettesmamiemone.model.RecipeFilter;
import com.github.maksadavid.recettesmamiemone.model.RecipeHardness;
import com.github.maksadavid.recettesmamiemone.model.RecipeType;
import com.github.maksadavid.recettesmamiemone.util.Fonts;
import com.github.maksadavid.recettesmamiemone.view.SegmentedControl;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 03. 11..
 */
public class RecipeFilterFragment extends Fragment {

    private SegmentedControl typeSegmentedControl;
    private SegmentedControl hardnessSegmentedControl;
    private RecipeFiltering recipeFiltering;

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_recipe_filter, container, false);

        ((TextView)rootView.findViewById(R.id.type_title_text_view)).setTypeface(Fonts.OpenSansBold);
        ((TextView)rootView.findViewById(R.id.hardness_title_text_view)).setTypeface(Fonts.OpenSansBold);

        typeSegmentedControl = (SegmentedControl) rootView.findViewById(R.id.type_segmented_control);
        hardnessSegmentedControl = (SegmentedControl) rootView.findViewById(R.id.hardness_segmented_control);

        TextView versionTextView = (TextView) rootView.findViewById(R.id.version_text_view);
        versionTextView.setTypeface(Fonts.MerriweatherRegular);
        versionTextView.setText("v " + BuildConfig.VERSION_NAME + " " + BuildConfig.VERSION_CODE);

        rootView.findViewById(R.id.appliquer_button).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                applyFilter();
            }
        });

        return rootView;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);

        try {
            recipeFiltering = (RecipeFiltering) context;
        } catch (ClassCastException e) {
            throw new ClassCastException(context.toString()
                    + " must implement RecipeFiltering");
        }
    }

    public void updateFilterOptions() {
        typeSegmentedControl.removeAllViews();
        for (RecipeType type : RecipeType.getAllTypes()) {
            typeSegmentedControl.addSegment(type.toString(), type.getDrawable(), type);
        }

        hardnessSegmentedControl.removeAllViews();
        for (RecipeHardness hardness : RecipeHardness.getAllHardnesses()) {
            hardnessSegmentedControl.addSegment(hardness.toString(), null, hardness);
        }
    }

    private void applyFilter() {

        // Just cast the ArrayList type
        ArrayList<RecipeType> validTypes = new ArrayList<>();
        for (Object tag : typeSegmentedControl.getActiveTags()) {
            validTypes.add((RecipeType) tag);
        }

        // Just cast the ArrayList type
        ArrayList<RecipeHardness> validHardnesses = new ArrayList<>();
        for (Object tag : hardnessSegmentedControl.getActiveTags()) {
            validHardnesses.add((RecipeHardness) tag);
        }

        recipeFiltering.setFilter(new RecipeFilter(validTypes, validHardnesses));
    }
}
