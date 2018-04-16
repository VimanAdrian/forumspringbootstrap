package artsoftconsult.study.repository;

import artsoftconsult.study.model.Lecture;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface LectureRepository extends PagingAndSortingRepository<Lecture, Long> {
}
