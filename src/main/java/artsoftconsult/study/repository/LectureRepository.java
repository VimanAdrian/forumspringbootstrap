package artsoftconsult.study.repository;

import artsoftconsult.study.model.Lecture;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface LectureRepository extends PagingAndSortingRepository<Lecture, Long> {
}
