package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.CategoryDTO;
import artsoftconsult.study.dto.model.PostCommentDTO;
import artsoftconsult.study.dto.model.PostDTO;
import artsoftconsult.study.dto.model.ReplyDTO;
import artsoftconsult.study.model.Category;
import artsoftconsult.study.model.Post;
import artsoftconsult.study.model.PostComment;
import artsoftconsult.study.model.Reply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class PostDtoConverter implements DtoConverter<Post, PostDTO> {

    @Autowired
    PostCommentDtoConverter postCommentDtoConverter;

    @Autowired
    CategoryDtoConverter categoryDtoConverter;

    @Autowired
    ReplyDtoConverter replyDtoConverter;

    @Autowired
    UserDtoConverter userDtoConverter;

    @Override
    public Post convertFromDto(PostDTO dto) {
        Post post = new Post();
        post.setRawContent(dto.getRawContent());
        post.setActive(dto.getActive());
        post.setContent(dto.getContent());
        post.setCreationDate(dto.getCreationDate());
        post.setPostId(dto.getPostId());
        post.setScore(dto.getScore());
        post.setTitle(dto.getTitle());
        post.setViews(dto.getViews());
        post.setUser(userDtoConverter.convertFromDto(dto.getUser()));
        post.setComments(postCommentDtoConverter.convertFromDtos(Arrays.asList(dto.getComments())).toArray(new PostComment[0]));
        post.setCategories(categoryDtoConverter.convertFromDtos(Arrays.asList(dto.getCategories())).toArray(new Category[0]));
        post.setReplies(replyDtoConverter.convertFromDtos(Arrays.asList(dto.getReplies())).toArray(new Reply[0]));
        return post;
    }

    @Override
    public PostDTO convertToDto(Post obj) {
        PostDTO postDTO = new PostDTO();
        postDTO.setRawContent(obj.getRawContent());
        postDTO.setActive(obj.getActive());
        postDTO.setContent(obj.getContent());
        postDTO.setCreationDate(obj.getCreationDate());
        postDTO.setPostId(obj.getPostId());
        postDTO.setScore(obj.getScore());
        postDTO.setTitle(obj.getTitle());
        postDTO.setViews(obj.getViews());
        postDTO.setUser(userDtoConverter.convertToDto(obj.getUser()));
        postDTO.setComments(postCommentDtoConverter.convertToDtos(Arrays.asList(obj.getComments())).toArray(new PostCommentDTO[0]));
        postDTO.setCategories(categoryDtoConverter.convertToDtos(Arrays.asList(obj.getCategories())).toArray(new CategoryDTO[0]));
        postDTO.setReplies(replyDtoConverter.convertToDtos(Arrays.asList(obj.getReplies())).toArray(new ReplyDTO[0]));
        return postDTO;
    }

    @Override
    public List<Post> convertFromDtos(List<PostDTO> dtos) {
        List<Post> posts = new ArrayList<>();
        for (PostDTO postDto:dtos) {
            posts.add(convertFromDto(postDto));
        }
        return posts;
    }

    @Override
    public List<PostDTO> convertToDtos(List<Post> objs) {
        List<PostDTO> postDTOS = new ArrayList<>();
        for (Post post:objs) {
            postDTOS.add(convertToDto(post));
        }
        return postDTOS;
    }
}
