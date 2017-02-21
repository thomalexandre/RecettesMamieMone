package com.github.maksadavid.recettesmamiemone.viewholder;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.R;

/**
 * Created by maksadavid on 2017. 02. 21..
 */
public class RecipeViewHolder extends RecyclerView.ViewHolder {

    public final TextView title;

    public RecipeViewHolder(View view) {
        super(view);
        title = (TextView) view.findViewById(R.id.title);
    }

    @Override
    public String toString() {
        return super.toString() + " '" + title.getText() + "'";
    }
}