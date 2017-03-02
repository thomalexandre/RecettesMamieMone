package com.github.maksadavid.recettesmamiemone.viewholder;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.R;
import com.github.maksadavid.recettesmamiemone.util.Fonts;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class RecipeViewHolder extends RecyclerView.ViewHolder {

    public final View view;
    public final TextView titleTextView;
    public final ImageView imageView;

    public RecipeViewHolder(View view) {
        super(view);
        this.view = view;
        titleTextView = (TextView) view.findViewById(R.id.title);
        titleTextView.setTypeface(Fonts.OpenSansRegular);
        imageView = (ImageView) view.findViewById(R.id.image_view);
    }

    @Override
    public String toString() {
        return super.toString() + " '" + titleTextView.getText() + "'";
    }
}