package artsoftconsult.study.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class ReplyRepositoryImpl implements ReplyRepositoryCustom {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void markNotNew(Long questionId, Long userId) {
        jdbcTemplate.update("DELETE FROM user_new_replies WHERE question_id = ? and user_id = ?", questionId, userId);
    }
}
