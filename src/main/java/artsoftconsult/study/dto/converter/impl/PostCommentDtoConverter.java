package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.PostCommentDTO;
import artsoftconsult.study.model.PostComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class PostCommentDtoConverter implements DtoConverter<PostComment, PostCommentDTO> {

    @Autowired
    PostDtoConverter postDtoConverter;

    @Autowired
    UserDtoConverter userDtoConverter;

    @Override
    public PostComment convertFromDto(PostCommentDTO dto) {
        PostComment postComment = new PostComment();
        postComment.setContent(dto.getContent());
        postComment.setCommentId(dto.getCommentId());
        postComment.setCreationDate(dto.getCreationDate());
        postComment.setUser(userDtoConverter.convertFromDto(dto.getUser()));
        postComment.setPost(postDtoConverter.convertFromDto(dto.getPost()));
        return postComment;
    }

    @Override
    public PostCommentDTO convertToDto(PostComment obj) {
        PostCommentDTO postCommentDto = new PostCommentDTO();
        postCommentDto.setContent(obj.getContent());
        postCommentDto.setCommentId(obj.getCommentId());
        postCommentDto.setCreationDate(obj.getCreationDate());
        postCommentDto.setUser(userDtoConverter.convertToDto(obj.getUser()));
        postCommentDto.setPost(postDtoConverter.convertToDto(obj.getPost()));
        return postCommentDto;
    }

    @Override
    public List<PostComment> convertFromDtos(List<PostCommentDTO> dtos) {
        List<PostComment> postComments = new ArrayList<>();
        for (PostCommentDTO  postCommentDTO:dtos) {
            postComments.add(convertFromDto(postCommentDTO));
        }
        return postComments;
    }

    @Override
    public List<PostCommentDTO> convertToDtos(List<PostComment> objs) {
        List<PostCommentDTO> postCommentDTOS = new ArrayList<>();
        for (PostComment postComment:objs) {
            postCommentDTOS.add(convertToDto(postComment));
        }
        return postCommentDTOS;
    }
}
