package artsoftconsult.study.validator;

import artsoftconsult.study.model.Post;
import org.springframework.stereotype.Component;

@Component
public class PostValidator {

    public PostValidator() {

    }

    public boolean validatePost(Post post) {
        if (post.getContent() == null)
            return false;
        if (post.getTitle() == null)
            return false;
        return true;
    }
}
