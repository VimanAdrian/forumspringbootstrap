package artsoftconsult.study.repository;

import artsoftconsult.study.model.QuestionComment;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface QuestionCommentRepository extends PagingAndSortingRepository<QuestionComment, Long> {
}
