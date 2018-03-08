package artsoftconsult.study.dto.converter;

import artsoftconsult.study.dto.model.CategoryDTO;
import artsoftconsult.study.model.Category;

import java.util.ArrayList;
import java.util.List;

public interface DtoConverter<O, D> {

     O convertFromDto(D dto);

     D convertToDto(O obj);

     List<O> convertFromDtos(List<D> dtos);

     List<D> convertToDtos(List<O> objs);
}
