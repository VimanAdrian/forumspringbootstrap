package artsoftconsult.study.repository;

import artsoftconsult.study.model.PageComment;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface PageCommentRepository extends PagingAndSortingRepository<PageComment, Long> {
    PageComment saveAndFlush(PageComment pageComment);
}
