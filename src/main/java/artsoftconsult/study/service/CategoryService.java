package artsoftconsult.study.service;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.repository.CategoryRepository;
import com.google.common.collect.Iterables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public Category[] getAllCategories()  {
        return Iterables.toArray(categoryRepository.findAll(), Category.class);
    }

    public void save(Long postGeneratedId, String tagString) {
        if (postGeneratedId != -1) {
            for (String tag : tagString.split(",")) {
                Category categoryFromDb = categoryRepository.findByTitle(tag.toLowerCase());
                if (categoryFromDb == null) {
                    Category cat = new Category();
                    cat.setTitle(tag.toLowerCase());
                    try {
                        cat.setUrl(URLEncoder.encode(cat.getTitle(), "UTF-8"));
                    } catch (UnsupportedEncodingException e) {
                        e.printStackTrace();
                    }
                    Long categoryGeneratedId = categoryRepository.save(cat).getCategoryId();
                    if (categoryGeneratedId != -1) {
                        categoryRepository.saveAssociation(postGeneratedId, categoryGeneratedId);
                    }
                } else {
                    categoryRepository.saveAssociation(postGeneratedId, categoryFromDb.getCategoryId());
                }
            }
        }
    }
}
