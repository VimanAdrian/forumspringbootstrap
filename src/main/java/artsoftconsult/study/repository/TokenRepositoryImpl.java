package artsoftconsult.study.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class TokenRepositoryImpl implements TokenRepositoryCustom{

    @Autowired
    private DriverManagerDataSource driverManagerDataSource;

    public boolean saveToken(Long userId, String token) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO activation_tokens(user_id, token, creationdate) VALUES (?,?,?)")) {
            preStmt.setLong(1, userId);
            preStmt.setString(2, token);
            preStmt.setLong(3, System.currentTimeMillis());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public boolean deleteToken(Long userId) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM activation_tokens WHERE user_id = ?")) {
            preStmt.setLong(1, userId);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public long findToken(String token, Long userId) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return 0;
        }
        try (PreparedStatement preStmt = con.prepareStatement("SELECT creationDate FROM activation_tokens WHERE user_id=? AND token=?")) {
            preStmt.setLong(1, userId);
            preStmt.setString(2, token);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getLong(1);
            } else
                return 0;
        } catch (SQLException e) {
            return 0;
        }
    }

    public boolean deletePasswordReset(Long userId) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM password_tokens WHERE user_id = ?")) {
            preStmt.setLong(1, userId);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public boolean savePasswordReset(Long userId, String token) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO password_tokens(user_id, token, creation_date) VALUES (?,?,?)")) {
            preStmt.setLong(1, userId);
            preStmt.setString(2, token);
            preStmt.setLong(3, System.currentTimeMillis());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public Long findPasswordResetToken(String token, Long userId) {
        Connection con = null;
        try {
            con = driverManagerDataSource.getConnection();
        } catch (SQLException e) {
            return null;
        }
        try (PreparedStatement preStmt = con.prepareStatement("SELECT creation_date FROM password_tokens WHERE user_id=? AND token=?")) {
            preStmt.setLong(1, userId);
            preStmt.setString(2, token);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getLong(1);
            } else
                return null;
        } catch (SQLException e) {
            return null;
        }
    }

}
