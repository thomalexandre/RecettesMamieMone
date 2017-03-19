package com.github.maksadavid.recettesmamiemone.viewholder;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.github.maksadavid.recettesmamiemone.R;

/**
 * Created by maksadavid on 2017. 03. 01..
 */
public class PhotoCarouselViewHolder extends RecyclerView.ViewHolder {

    public final View view;
    public final ImageView imageView;

    public PhotoCarouselViewHolder(View view) {
        super(view);
        this.view = view;
        imageView = (ImageView) view.findViewById(R.id.image_view);
    }

}
