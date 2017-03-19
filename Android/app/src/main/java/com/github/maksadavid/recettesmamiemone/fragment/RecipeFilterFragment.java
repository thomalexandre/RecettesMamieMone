package com.github.maksadavid.recettesmamiemone.fragment;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.BuildConfig;
import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.activity.RecipeFiltering;
import com.github.maksadavid.recettesmamiemone.model.RecipeFilter;
import com.github.maksadavid.recettesmamiemone.model.RecipeHardness;
import com.github.maksadavid.recettesmamiemone.model.RecipeType;
import com.github.maksadavid.recettesmamiemone.util.Fonts;

import java.util.ArrayList;

/**
 * Created by maksadavid on 2017. 03. 11..
 */
public class RecipeFilterFragment extends Fragment {

    private CheckBox entryCheckbox;
    private CheckBox mainDishCheckbox;
    private CheckBox dessertCheckbox;

    private RadioButton allButton;
    private RadioButton easyButton;
    private RadioButton intermediateButton;
    private RadioButton hardButton;

    private RecipeFiltering recipeFiltering;

    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_recipe_filter, container, false);

        ((TextView)rootView.findViewById(R.id.type_title_text_view)).setTypeface(Fonts.OpenSansBold);
        ((TextView)rootView.findViewById(R.id.hardness_title_text_view)).setTypeface(Fonts.OpenSansBold);

        TextView versionTextView = (TextView) rootView.findViewById(R.id.version_text_view);
        versionTextView.setTypeface(Fonts.MerriweatherRegular);
        versionTextView.setText("v " + BuildConfig.VERSION_NAME + " " + BuildConfig.VERSION_CODE);

        entryCheckbox = (CheckBox) rootView.findViewById(R.id.entry_checkbox);
        entryCheckbox.setTypeface(Fonts.MerriweatherRegular);
        entryCheckbox.setChecked(true);
        mainDishCheckbox = (CheckBox) rootView.findViewById(R.id.main_dish_checkbox);
        mainDishCheckbox.setTypeface(Fonts.MerriweatherRegular);
        mainDishCheckbox.setChecked(true);
        dessertCheckbox = (CheckBox) rootView.findViewById(R.id.dessert_checkbox);
        dessertCheckbox.setTypeface(Fonts.MerriweatherRegular);
        dessertCheckbox.setChecked(true);
        allButton = (RadioButton) rootView.findViewById(R.id.all_button);
        allButton.setTypeface(Fonts.MerriweatherRegular);
        allButton.setChecked(true);
        easyButton = (RadioButton) rootView.findViewById(R.id.easy_button);
        easyButton.setTypeface(Fonts.MerriweatherRegular);
        intermediateButton = (RadioButton) rootView.findViewById(R.id.intermediate_button);
        intermediateButton.setTypeface(Fonts.MerriweatherRegular);
        hardButton = (RadioButton) rootView.findViewById(R.id.difficult_button);
        hardButton.setTypeface(Fonts.MerriweatherRegular);

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

    private void applyFilter() {

        ArrayList<RecipeType> validTypes = new ArrayList<>();

        if (entryCheckbox.isChecked()) {
            validTypes.add(new RecipeType("type_10"));
        }

        if (mainDishCheckbox.isChecked()) {
            validTypes.add(new RecipeType("type_20"));
        }

        if (dessertCheckbox.isChecked()) {
            validTypes.add(new RecipeType("type_30"));
        }

        ArrayList<RecipeHardness> validHardnesses = new ArrayList<>();

        if (allButton.isChecked()) {
            validHardnesses.add(new RecipeHardness("hardness_0"));
            validHardnesses.add(new RecipeHardness("hardness_1"));
            validHardnesses.add(new RecipeHardness("hardness_2"));
        }
        else if (easyButton.isChecked()) {
            validHardnesses.add(new RecipeHardness("hardness_0"));
        }
        else if (intermediateButton.isChecked()) {
            validHardnesses.add(new RecipeHardness("hardness_1"));
        }
        else if (hardButton.isChecked()) {
            validHardnesses.add(new RecipeHardness("hardness_2"));
        }

        recipeFiltering.setFilter(new RecipeFilter(validTypes, validHardnesses));
    }
}
