package artsoftconsult.study.repository.implementation;

import artsoftconsult.study.model.User;
import artsoftconsult.study.repository.HibernateRepository;
import artsoftconsult.study.repository.IRepository;
import artsoftconsult.study.repository.dbUtils.DbConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository
public class UserRepository extends HibernateRepository implements IRepository {

    @Autowired
    private DbConnection db;

    public UserRepository() {
    }

    public Integer save(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO users(username, password, firstName, lastName, email) " +
                "VALUES(?,?,?,?,?)", PreparedStatement.RETURN_GENERATED_KEYS)) {
            preStmt.setString(1, user.getUsername());
            preStmt.setString(2, user.getPassword());
            preStmt.setString(3, user.getFirstName());
            preStmt.setString(4, user.getLastName());
            preStmt.setString(5, user.getEmail());
            preStmt.executeUpdate();
            ResultSet resultSet = preStmt.getGeneratedKeys();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean update(User user) {
        System.out.println("updateuser");
        System.out.println(user);
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users set " +
                "username = IFNULL(?, username)," +
                "firstName = IFNULL(?, firstName)," +
                "lastName = IFNULL(?, lastName)," +
                "email = IFNULL(?, email)," +
                "profileImage = IFNULL(?, profileImage) WHERE username = ?")) {
            preStmt.setString(1,user.getNewUsernameForUpdate());
            preStmt.setString(2, user.getFirstNameForUpdate());
            preStmt.setString(3, user.getLastNameForUpdate());
            preStmt.setString(4, user.getEmailForUpdate());
            preStmt.setString(5, user.getProfileImageForUpdate());
            preStmt.setString(6, user.getUsernameForUpdate());
            preStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean makeAdmin(User user) {
        //System.out.println(user);
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET role='ROLE_ADMIN' WHERE username=?")) {
            preStmt.setString(1, user.getUsername());
            preStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User findById(Integer userID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt1 = con.prepareStatement("SELECT * FROM users WHERE userID=?")) {
            preStmt1.setInt(1, userID);
            return find(preStmt1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findByUsername(String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM users WHERE username=?")) {
            preStmt.setString(1, username);
            return find(preStmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private User find(PreparedStatement preparedStatement) throws SQLException {
        User user = new User();
        ResultSet resultSet1 = preparedStatement.executeQuery();
        while (resultSet1.next()) {
            user.setUserId(resultSet1.getInt("userID"));
            user.setUsername(resultSet1.getString("username"));
            user.setFirstName(resultSet1.getString("firstName"));
            user.setLastName(resultSet1.getString("lastName"));
            user.setEmail(resultSet1.getString("email"));
            user.setCreationDate(resultSet1.getTimestamp("creationDate"));
            user.setRole(resultSet1.getString("role"));
            user.setProfileImage(resultSet1.getString("profileImage"));
            user.setEnabled(resultSet1.getByte("enabled"));
        }
        return user;
    }

    public Integer findId(String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT userID FROM users WHERE username=?")) {
            preStmt.setString(1, username);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public void updateProfileImage(String profileImage, String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET profileImage=? WHERE username=?")) {
            preStmt.setString(1, profileImage);
            preStmt.setString(2, username);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Integer toggleEnabled(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET enabled=NOT(enabled) WHERE username=?")) {
            preStmt.setString(1, user.getUsername());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return getEnabled(user);
    }

    public void enable(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET enabled='1' WHERE userID=?")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Integer getEnabled(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT enabled FROM users WHERE username=?")) {
            preStmt.setString(1, user.getUsername());
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                if (resultSet.getBoolean("enabled"))
                    return 1;
                return 2;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public User[] getAll() {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM users WHERE role != 'ROLE_ADMIN'")) {
            return getAll(preStmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User[] getAll(Integer page) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM users WHERE role != 'ROLE_ADMIN' LIMIT ?,?")) {
            preStmt.setInt(1, page * 20);
            preStmt.setInt(2, 20);
            return getAll(preStmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private User[] getAll(PreparedStatement preStmt) throws SQLException {
        List<User> userList = new ArrayList();
        ResultSet resultSet1 = preStmt.executeQuery();
        while (resultSet1.next()) {
            User user = new User();
            user.setUserId(resultSet1.getInt("userID"));
            user.setUsername(resultSet1.getString("username"));
            user.setFirstName(resultSet1.getString("firstName"));
            user.setLastName(resultSet1.getString("lastName"));
            user.setEmail(resultSet1.getString("email"));
            user.setCreationDate(resultSet1.getTimestamp("creationDate"));
            user.setProfileImage(resultSet1.getString("profileImage"));
            user.setEnabled(resultSet1.getByte("enabled"));
            userList.add(user);
        }
        return userList.toArray(new User[0]);
    }

    public Integer getAllNext() {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT COUNT(userID) FROM users WHERE role != 'ROLE_ADMIN'")) {
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public boolean saveToken(User user, String token) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO activation_tokens(userID, token) VALUES (?,?)")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.setString(2, token);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            //saveToken(user, token);
        }
        return true;
    }

    public void deleteToken(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM activation_tokens WHERE userID = ?")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean useToken(String token, User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT creationDate FROM activation_tokens WHERE userID=? AND token=?")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.setString(2, token);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                long timeCurrent = new Date().getTime();
                long timeOld = resultSet.getLong(1);
                if (timeOld - timeCurrent > 7200000) {
                    return false;
                } else {
                    enable(user);
                    return true;
                }
            } else
                return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deletePasswordReset(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM password_tokens WHERE userID = ?")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean savePasswordReset(User user, String token) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO password_tokens(userID, token) VALUES (?,?)")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.setString(2, token);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            //saveToken(user, token);
        }
        return true;
    }

    public boolean usePasswordReset(String token, User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT creationDate FROM password_tokens WHERE userID=? AND token=?")) {
            preStmt.setInt(1, user.getUserId());
            preStmt.setString(2, token);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                long timeCurrent = new Date().getTime();
                long timeOld = resultSet.getLong(1);
                if (timeOld - timeCurrent > 7200000) {
                    return false;
                } else {
                    return true;
                }
            } else
                return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void resetPassword(User user) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET password=? WHERE userID=?")) {
            preStmt.setString(1, user.getPassword());
            preStmt.setInt(2, user.getUserId());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void newReply(Integer userId, Integer postId){
        Connection con = db.getConnection();
        try(PreparedStatement preStmt = con.prepareStatement("INSERT INTO users_new_reply(userID, postID) VALUES (?,?)")){
            preStmt.setInt(1,userId);
            preStmt.setInt(2,postId);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String findEmail(String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT email FROM users WHERE username=?")) {
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                return resultSet.getString(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void block(String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE users SET accountNonLocked = 0 WHERE username=?")) {
            preStmt.setString(1, username);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
