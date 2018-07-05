package artsoftconsult.study.repository;

import artsoftconsult.study.model.VirtualClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.ArrayList;
import java.util.List;

public class VirtualClassRepositoryImpl implements VirtualClassRepositoryCustom {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<VirtualClass> newActivity(Long userId) {
        List<Long> virtualClassIds = new ArrayList<>(jdbcTemplate.query("SELECT virtual_class_id FROM virtual_class_notifications WHERE user_id = ? ORDER BY virtual_class_notification_id DESC LIMIT 5", new Object[]{userId},
                (rs, rowNum) -> (rs.getLong("virtual_class_id"))));
        List<VirtualClass> results = new ArrayList<>();
        virtualClassIds.forEach(virtualClassId ->
                results.addAll((jdbcTemplate.query("SELECT title, views, score FROM virtual_classes WHERE virtual_class_id = ?", new Object[]{virtualClassId},
                        (rs, rowNum) -> new VirtualClass(virtualClassId, rs.getString("title"), rs.getLong("views"), rs.getLong("score")))))
        );
        return results;
    }

}
