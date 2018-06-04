package artsoftconsult.study.repository;

import artsoftconsult.study.model.Category;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface CategoryRepository extends PagingAndSortingRepository<Category, Long>, CategoryRepositoryCustom {

    Category saveAndFlush(Category category);

    Category findByTitle(@Param("title")String title);

    Category findByUrl(@Param("url") String url);

    @Modifying
    @Query(value = "INSERT INTO question_categories(question_id, category_id) VALUES (:questionId, :categoryId)", nativeQuery = true)
    void saveAssociationForQuestion(@Param("questionId") Long questionId, @Param("categoryId") Long categoryId);

    @Modifying
    @Query(value = "INSERT INTO virtual_class_categories(virtual_class_id, category_id) VALUES (:virtualClassId, :categoryId)", nativeQuery = true)
    void saveAssociationForVirtualClass(@Param("virtualClassId") Long virtualClassId, @Param("categoryId") Long categoryId);

}
