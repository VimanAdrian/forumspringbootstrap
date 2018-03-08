package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.ReplyCommentDTO;
import artsoftconsult.study.dto.model.ReplyDTO;
import artsoftconsult.study.model.Reply;
import artsoftconsult.study.model.ReplyComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Component
public class ReplyDtoConverter implements DtoConverter<Reply, ReplyDTO> {

    @Autowired
    UserDtoConverter userDtoConverter;

    @Autowired
    PostDtoConverter postDtoConverter;

    @Autowired
    ReplyCommentDtoConverter replyCommentDtoConverter;

    @Override
    public Reply convertFromDto(ReplyDTO dto) {
        Reply reply = new Reply();
        reply.setContent(dto.getContent());
        reply.setRawContent(dto.getRawContent());
        reply.setBestAnswer(dto.getBestAnswer());
        reply.setCreationDate(dto.getCreationDate());
        reply.setEnabled(dto.getEnabled());
        reply.setReplyId(dto.getReplyId());
        reply.setScore(dto.getScore());
        reply.setReplyVoteType(dto.getReplyVoteType());
        reply.setPost(postDtoConverter.convertFromDto(dto.getPost()));
        reply.setUser(userDtoConverter.convertFromDto(dto.getUser()));
        reply.setComments(replyCommentDtoConverter.convertFromDtos(Arrays.asList(dto.getComments())).toArray(new ReplyComment[0]));
        return reply;
    }

    @Override
    public ReplyDTO convertToDto(Reply obj) {
        ReplyDTO replyDTO = new ReplyDTO();
        replyDTO.setContent(obj.getContent());
        replyDTO.setRawContent(obj.getRawContent());
        replyDTO.setBestAnswer(obj.getBestAnswer());
        replyDTO.setCreationDate(obj.getCreationDate());
        replyDTO.setEnabled(obj.getEnabled());
        replyDTO.setReplyId(obj.getReplyId());
        replyDTO.setScore(obj.getScore());
        replyDTO.setReplyVoteType(obj.getReplyVoteType());
        replyDTO.setPost(postDtoConverter.convertToDto(obj.getPost()));
        replyDTO.setUser(userDtoConverter.convertToDto(obj.getUser()));
        replyDTO.setComments(replyCommentDtoConverter.convertToDtos(Arrays.asList(obj.getComments())).toArray(new ReplyCommentDTO[0]));
        return replyDTO;
    }

    @Override
    public List<Reply> convertFromDtos(List<ReplyDTO> dtos) {
        List<Reply> replies = new ArrayList<>();
        for (ReplyDTO replyDTO :dtos) {
            replies.add(convertFromDto(replyDTO));
        }
        return replies;
    }

    @Override
    public List<ReplyDTO> convertToDtos(List<Reply> objs) {
        List<ReplyDTO> replieDTOS = new ArrayList<>();
        for (Reply reply :objs) {
            replieDTOS.add(convertToDto(reply));
        }
        return replieDTOS;
    }
}
