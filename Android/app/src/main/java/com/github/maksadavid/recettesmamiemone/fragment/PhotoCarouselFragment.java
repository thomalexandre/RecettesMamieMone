package com.github.maksadavid.recettesmamiemone.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import com.github.maksadavid.recettesmamiemone.util.Fonts;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.activity.PhotoPresenterActivity;
import com.github.maksadavid.recettesmamiemone.activity.RecipeDetailActivity;
import com.github.maksadavid.recettesmamiemone.model.Recipe;
import com.github.maksadavid.recettesmamiemone.service.ServiceHolder;
import com.github.maksadavid.recettesmamiemone.viewholder.PhotoCarouselViewHolder;

/**
 * Created by maksadavid on 2017. 03. 01..
 */
public class PhotoCarouselFragment extends Fragment {

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View rootView = inflater.inflate(R.layout.fragment_photo_carousel, container, false);

        if (getArguments().containsKey(RecipeDetailActivity.ARG_RECIPE)) {
            Recipe recipe = (Recipe) getArguments().getSerializable(RecipeDetailActivity.ARG_RECIPE);
            RecyclerView recyclerView = (RecyclerView) rootView.findViewById(R.id.recycle_view);
            recyclerView.setAdapter(new SimpleItemRecyclerViewAdapter(recipe));
        }

        TextView photosTitle = ((TextView)rootView.findViewById(R.id.photos_title_text_view));
        photosTitle.setTypeface(Fonts.OpenSansBold);

        return rootView;
    }

    public class SimpleItemRecyclerViewAdapter extends RecyclerView.Adapter<PhotoCarouselViewHolder> {

        private final Recipe recipe;

        public SimpleItemRecyclerViewAdapter(Recipe recipes) {
            this.recipe = recipes;
        }

        @Override
        public PhotoCarouselViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.item_photo, parent, false);
            return new PhotoCarouselViewHolder(view);
        }

        @Override
        public void onBindViewHolder(final PhotoCarouselViewHolder holder, final int position) {
            final String path = recipe.getPhotoPaths().get(position);
            ServiceHolder.recipeService.loadImageForRecipe(PhotoCarouselFragment.this.getActivity(), recipe, holder.imageView, path);
            holder.view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(PhotoCarouselFragment.this.getActivity(), PhotoPresenterActivity.class);
                    Bundle bundle = new Bundle();
                    bundle.putSerializable(PhotoPresenterActivity.ARG_RECIPE, recipe);
                    bundle.putSerializable(PhotoPresenterActivity.ARG_PHOTO_INDEX, position);
                    intent.putExtras(bundle);
                    PhotoCarouselFragment.this.getActivity().startActivity(intent);
                }
            });
        }

        @Override
        public int getItemCount() {
            return recipe.getPhotoPaths().size();
        }

    }
}
