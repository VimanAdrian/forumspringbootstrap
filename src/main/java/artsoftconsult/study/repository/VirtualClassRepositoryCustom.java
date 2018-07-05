package artsoftconsult.study.repository;

import artsoftconsult.study.model.VirtualClass;

import java.util.List;

public interface VirtualClassRepositoryCustom {

    List<VirtualClass> newActivity(Long userId);

}
