package artsoftconsult.study.repository;

import artsoftconsult.study.model.ReplyComment;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface ReplyCommentRepository extends PagingAndSortingRepository<ReplyComment, Long> {
}
