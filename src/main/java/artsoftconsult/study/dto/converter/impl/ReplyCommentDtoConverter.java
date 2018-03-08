package artsoftconsult.study.dto.converter.impl;

import artsoftconsult.study.dto.converter.DtoConverter;
import artsoftconsult.study.dto.model.ReplyCommentDTO;
import artsoftconsult.study.model.ReplyComment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class ReplyCommentDtoConverter implements DtoConverter<ReplyComment, ReplyCommentDTO> {

    @Autowired
    ReplyDtoConverter replyDtoConverter;

    @Autowired
    UserDtoConverter userDtoConverter;

    @Override
    public ReplyComment convertFromDto(ReplyCommentDTO dto) {
        ReplyComment replyComment = new ReplyComment();
        replyComment.setCommentId(dto.getCommentId());
        replyComment.setContent(dto.getContent());
        replyComment.setCreationDate(dto.getCreationDate());
        replyComment.setReply(replyDtoConverter.convertFromDto(dto.getReply()));
        replyComment.setUser(userDtoConverter.convertFromDto(dto.getUser()));
        return replyComment;
    }

    @Override
    public ReplyCommentDTO convertToDto(ReplyComment obj) {
        ReplyCommentDTO replyCommentDTO = new ReplyCommentDTO();
        replyCommentDTO.setCommentId(obj.getCommentId());
        replyCommentDTO.setContent(obj.getContent());
        replyCommentDTO.setCreationDate(obj.getCreationDate());
        replyCommentDTO.setReply(replyDtoConverter.convertToDto(obj.getReply()));
        replyCommentDTO.setUser(userDtoConverter.convertToDto(obj.getUser()));
        return replyCommentDTO;
    }

    @Override
    public List<ReplyComment> convertFromDtos(List<ReplyCommentDTO> dtos) {
        List<ReplyComment> replyComments = new ArrayList<>();
        for (ReplyCommentDTO replyCommentDto:dtos) {
            replyComments.add(convertFromDto(replyCommentDto));
        }
        return replyComments;
    }

    @Override
    public List<ReplyCommentDTO> convertToDtos(List<ReplyComment> objs) {
        List<ReplyCommentDTO> replyCommentDTOS = new ArrayList<>();
        for (ReplyComment replyComment:objs) {
            replyCommentDTOS.add(convertToDto(replyComment));
        }
        return replyCommentDTOS;
    }
}
