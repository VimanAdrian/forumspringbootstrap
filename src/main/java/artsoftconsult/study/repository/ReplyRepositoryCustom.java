package artsoftconsult.study.repository;

public interface ReplyRepositoryCustom {

    void markNotNew(Long questionId, Long userId);
}
