package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.CategoryDTO;
import artsoftconsult.study.model.Category;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class CategoryDtoConverter implements DtoConverter<Category, CategoryDTO> {

    @Override
    public Category convertFromDto(CategoryDTO categoryDTO){
        Category category = new Category();
        category.setCategoryId(categoryDTO.getCategoryId());
        category.setTitle(categoryDTO.getTitle());
        category.setUrl(categoryDTO.getUrl());
        return category;
    }

    @Override
    public CategoryDTO convertToDto(Category category){
        CategoryDTO categoryDTO = new CategoryDTO();
        categoryDTO.setCategoryId(category.getCategoryId());
        categoryDTO.setTitle(category.getTitle());
        categoryDTO.setUrl(category.getUrl());
        return categoryDTO;
    }

    @Override
    public List<Category> convertFromDtos(List<CategoryDTO> categoryDTOS){
        List<Category> categories = new ArrayList<>();
        for (CategoryDTO categoryDTO : categoryDTOS) {
            categories.add(convertFromDto(categoryDTO));
        }
        return categories;
    }

    @Override
    public List<CategoryDTO> convertToDtos(List<Category> categories){
        List<CategoryDTO> categoryDTOS = new ArrayList<>();
        for (Category category : categories) {
            categoryDTOS.add(convertToDto(category));
        }
        return categoryDTOS;
    }

}

