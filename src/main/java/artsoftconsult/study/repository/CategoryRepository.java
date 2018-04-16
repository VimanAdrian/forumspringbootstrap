package artsoftconsult.study.repository;

import artsoftconsult.study.model.Category;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

public interface CategoryRepository extends PagingAndSortingRepository<Category, Long> {

    Category findByTitle(@Param("title")String title);

    @Modifying
    @Query(value = "INSERT INTO question_categories(question_id, category_id) VALUES (:questionId, :categoryId)", nativeQuery = true)
    void saveAssociation(@Param("questionId")Long questionId, @Param("categoryId")Long categoryId);

}
