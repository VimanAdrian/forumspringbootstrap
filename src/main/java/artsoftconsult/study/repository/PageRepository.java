package artsoftconsult.study.repository;

import artsoftconsult.study.model.Page;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface PageRepository extends PagingAndSortingRepository<Page, Long> {
}
