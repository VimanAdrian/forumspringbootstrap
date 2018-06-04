package artsoftconsult.study.repository;

import artsoftconsult.study.model.Page;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

public interface PageRepository extends PagingAndSortingRepository<Page, Long> {

    Page findByPageIdAndDeletedFalse(Long pageId);

    @Modifying
    @Query(value = "UPDATE pages SET content=:content WHERE page_id=:pageId", nativeQuery = true)
    void updateContent(@Param("content") String content, @Param("pageId") Long pageId);

    @Modifying
    @Query(value = "UPDATE pages SET deleted = TRUE where page_id=:pageId", nativeQuery = true)
    void logicalDelete(@Param("pageId") Long pageId);

    Page findByPageId(Long pageId);
}
