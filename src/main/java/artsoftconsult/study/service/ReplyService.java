package artsoftconsult.study.service;

import artsoftconsult.study.repository.ReplyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyService {

    @Autowired
    private ReplyRepository replyRepository;

    public Integer findCount(Long questionId, boolean role_admin) {
        if(role_admin)
            return replyRepository.findCount(questionId);
        else
            return replyRepository.findCountWithoutDisabled(questionId);
    }
}
