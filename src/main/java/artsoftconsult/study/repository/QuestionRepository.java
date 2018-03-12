package artsoftconsult.study.repository;

import artsoftconsult.study.model.Question;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface QuestionRepository extends PagingAndSortingRepository<Question, Long> {
}
