package artsoftconsult.study.repository;

import artsoftconsult.study.model.Question;
import artsoftconsult.study.repository.QuestionRepository;
import artsoftconsult.study.repository.QuestionRepositoryCustom;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.persistence.EntityManager;
import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

public class QuestionRepositoryImpl implements QuestionRepositoryCustom {

    @Autowired
    private EntityManager entityManager;

    @Autowired
    private DataSource dataSource;

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public List<Question> newReplies(Long userId) {
        List<Long> questionIds = new ArrayList<>(jdbcTemplate.query("SELECT question_id FROM user_new_replies WHERE user_id = ?", new Object[]{userId},
                (rs, rowNum) -> (rs.getLong("question_id"))));
        return new ArrayList<>(jdbcTemplate.query("SELECT question_id, title, views, score FROM question WHERE question_id = ?", questionIds.toArray(new Long[0]),
                (rs, rowNum) -> new Question(rs.getLong("question_id"), rs.getString("title"), rs.getLong("views"), rs.getLong("score"))));
    }

    @Override
    public List<Question> topQuestion(Long userId) {
        return new ArrayList<>(jdbcTemplate.query("SELECT * FROM question WHERE userID=? ORDER BY score DESC LIMIT 5", new Object[]{userId},
                (rs, rowNum) -> new Question(rs.getLong("question_id"), rs.getString("title"), rs.getLong("views"), rs.getLong("score"))));
    }
}
