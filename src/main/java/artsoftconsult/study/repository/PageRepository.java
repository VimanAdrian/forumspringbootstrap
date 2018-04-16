package artsoftconsult.study.repository;

import artsoftconsult.study.model.Page;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

public interface PageRepository extends PagingAndSortingRepository<Page, Long> {
}
