package artsoftconsult.study.repository;

import artsoftconsult.study.model.Question;
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
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Question> newReplies(Long userId) {
        List<Long> questionIds = new ArrayList<>(jdbcTemplate.query("SELECT question_id FROM user_new_replies WHERE user_id = ? ORDER BY user_new_reply_id DESC LIMIT 5", new Object[]{userId},
                (rs, rowNum) -> (rs.getLong("question_id"))));
        List<Question> results = new ArrayList<>();
        questionIds.forEach(questionId ->
                results.addAll((jdbcTemplate.query("SELECT question_id, title, views, score FROM questions WHERE question_id = ?", new Object[]{questionId},
                        (rs, rowNum) -> new Question(rs.getLong("question_id"), rs.getString("title"), rs.getLong("views"), rs.getLong("score")))))
        );
        return results;
    }

    @Override
    public List<Question> topQuestion(Long userId) {
        return new ArrayList<>(jdbcTemplate.query("SELECT * FROM questions WHERE user_id=? ORDER BY score DESC LIMIT 5", new Object[]{userId},
                (rs, rowNum) -> new Question(rs.getLong("question_id"), rs.getString("title"), rs.getLong("views"), rs.getLong("score"))));
    }
}
