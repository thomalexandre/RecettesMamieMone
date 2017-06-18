package me.athomas.recettesmamiemone.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import me.athomas.recettesmamiemone.R;
import me.athomas.recettesmamiemone.model.Recipe;
import me.athomas.recettesmamiemone.service.ServiceHolder;

/**
 * Created by maksadavid on 2017. 03. 02..
 */
public class PhotoPresenterActivity extends AppCompatActivity {

    public final static String ARG_RECIPE = "arg_recipe";
    public final static String ARG_PHOTO_INDEX = "photo_index";

    private Recipe recipe;
    private ViewPager viewPager;
    private int currentPageIndex = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_photo_presenter);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setDisplayShowHomeEnabled(true);

        recipe = (Recipe) getIntent().getExtras().getSerializable(ARG_RECIPE);

        PhotoPagerAdapter pagerAdapter = new PhotoPagerAdapter();
        viewPager = (ViewPager) findViewById(R.id.view_pager);
        viewPager.setAdapter(pagerAdapter);

        setTitle(recipe.getTitle());

        if (savedInstanceState != null) {
            currentPageIndex = (int) savedInstanceState.getSerializable(ARG_PHOTO_INDEX);
        }
        else {
            currentPageIndex = (int) getIntent().getExtras().getSerializable(ARG_PHOTO_INDEX);
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        viewPager.setCurrentItem(currentPageIndex, false);
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putSerializable(ARG_PHOTO_INDEX, viewPager.getCurrentItem());
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item.getItemId();
        if (id == android.R.id.home) {
            Intent intent = new Intent(this, RecipeDetailActivity.class);
            intent.putExtra(RecipeDetailActivity.ARG_RECIPE, recipe);
            NavUtils.navigateUpTo(this, intent);
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    class PhotoPagerAdapter extends PagerAdapter {

        @Override
        public int getCount() {
            return recipe.getPhotoPaths().size();
        }

        @Override
        public boolean isViewFromObject(View view, Object object) {
            return view == object;
        }

        @Override
        public Object instantiateItem(ViewGroup container, int position) {
            ImageView imageView = new ImageView(container.getContext());
            imageView.setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
            ServiceHolder.recipeService.loadImageForRecipe(container.getContext(), recipe, imageView, recipe.getPhotoPaths().get(position));
            container.addView(imageView);
            return imageView;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((View) object);
        }
    }
}
