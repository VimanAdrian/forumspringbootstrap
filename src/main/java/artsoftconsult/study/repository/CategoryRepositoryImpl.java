package artsoftconsult.study.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class CategoryRepositoryImpl implements CategoryRepositoryCustom {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private DriverManagerDataSource driverManagerDataSource;

    @Autowired
    private EntityManager entityManager;

    @Transactional(propagation = Propagation.REQUIRES_NEW)
    @Override
    public boolean deleteAssociationForVirtualClass(Long virtualClassId) {
//        String q = "DELETE FROM virtual_class_categories WHERE virtual_class_id = " + virtualClassId;
//        entityManager.createNativeQuery(q).executeUpdate();
//        entityManager.flush();
//        return true;
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM virtual_class_categories WHERE virtual_class_id = ?")) {
            preStmt.setLong(1, virtualClassId);
            preStmt.executeUpdate();
            con.commit();
            con.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }
}
