package artsoftconsult.study.repository;

import artsoftconsult.study.model.Question;

import java.util.List;

public interface QuestionRepositoryCustom {

    List<Question> newReplies(Long userId);

    List<Question> topQuestion(Long userId);

}
