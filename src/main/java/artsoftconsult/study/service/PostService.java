package artsoftconsult.study.service;

import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Post;
import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.implementation.PostRepository;
import artsoftconsult.study.repository.implementation.UserRepository;
import artsoftconsult.study.utils.MyAttributeProvider;
import artsoftconsult.study.utils.RandomUtils;
import artsoftconsult.study.validator.PostValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
public class PostService {

    @Autowired
    private PostRepository postRepository;
    @Autowired
    private PostValidator postValidator;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CategoryService categoryService;

    public PostService() {
    }


    public Integer save(Post post, String tagString) {
        String[] tags = RandomUtils.split(tagString);
        List<Category> categories = new ArrayList<>();
        for (String tag : tags) {
            Category cat = new Category();
            cat.setTitle(tag.toLowerCase());
            try {
                cat.setUrl(URLEncoder.encode(cat.getTitle(), "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            categories.add(cat);
        }
        post.setCategories(categories.toArray(new Category[0]));
        if (postValidator.validatePost(post))
            return postRepository.save(post);
        return -1;
    }

    public Integer saveHibernate(Post post, String tagString) {
        Integer postGeneratedId = -1;
        post.setUser(userRepository.findByUsername(post.getUser().getUsername()));
        if (postValidator.validatePost(post)) {
            postGeneratedId = postRepository.saveHibernate(post);
            categoryService.save(postGeneratedId, tagString);
        }
        return postGeneratedId;
    }

    public boolean vote(Integer postID, Integer userID, String type) {
        if (type.equals("Upvote")) {
            return postRepository.vote(postID, userID, 1);
        }
        return postRepository.vote(postID, userID, -1);
    }

    public boolean togglePostStatus(Integer postID) {
        return postRepository.togglePostStatus(postID);
    }

    public Post[] search(String search, String page, boolean disabled) {
        return postRepository.search(RandomUtils.split(search), Integer.valueOf(page), disabled);
    }

    public Post[] search(String page, boolean disabled) {
        return postRepository.search(Integer.valueOf(page), disabled);
    }

    public Post[] searchByTag(String tag, String page, boolean disabled) {
        return postRepository.searchByTag(tag, Integer.valueOf(page), disabled);
    }

    public Integer searchNext(String search, boolean disabled) {
        double nrPag = postRepository.searchNext(RandomUtils.split(search), disabled) / 20;
        return (int) Math.round(nrPag);
    }

    public Integer searchNext(boolean disabled) {
        double nrPag = postRepository.searchNext(disabled) / 20;
        return (int) Math.round(nrPag);
    }

    public Integer searchByTagNext(String tag, boolean disabled) {
        double nrPag = postRepository.searchByTagNext(tag, disabled) / 20;
        return (int) Math.round(nrPag);
    }

    public Post find(String postID, User currentUser, String page) {
        postRepository.markNotNew(postID, userRepository.findByUsername(currentUser.getUsername()));
        postRepository.incrementView(Integer.valueOf(postID));
        Post p = postRepository.find(Integer.valueOf(postID), currentUser, Integer.valueOf(page));
        Reply[] replies = p.getReplies();
        for (Reply re : replies) {
            re.setRawContent(re.getContent());
            re.setContent(MyAttributeProvider.commonMark(re.getContent()));
        }
        p.setReplies(sort(replies));
        p.setRawContent(p.getContent());
        p.setContent(MyAttributeProvider.commonMark(p.getContent()));
        return p;
    }

    private Reply[] sort(Reply[] replies) {
        Reply favorite = null;
        List<Reply> sortedReplies = new ArrayList<>();
        for (Reply reply : replies) {
            if (reply.getBestAnswer() == 1) {
                favorite = reply;
            } else {
                sortedReplies.add(reply);
            }
        }
        sortedReplies.sort(Comparator.comparing(Reply::getScore));
        if(sortedReplies.size()!=replies.length){
            sortedReplies.add(favorite);
        }
        Collections.reverse(sortedReplies);
        return sortedReplies.toArray(new Reply[0]);
    }

    public Post[] searchByUser(String userID, String page, boolean disabled) {
        return postRepository.searchByUser(Integer.valueOf(userID), Integer.valueOf(page), disabled);
    }

    public Integer searchByUserNext(String userID, boolean disabled) {
        double NrPag = postRepository.searchByUserNext(Integer.valueOf(userID), disabled) / 20;
        return (int) Math.round(NrPag);
    }

    public void update(Post post) {
        if (postValidator.validatePost(post))
            postRepository.update(post);
    }

    public Integer voteTypesAvailable(Integer postID, Integer userID) {
        return postRepository.hasVote(postID, userID);
    }
}
