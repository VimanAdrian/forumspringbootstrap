package artsoftconsult.study.repository.implementation;

import artsoftconsult.study.repository.HibernateRepository;
import artsoftconsult.study.repository.IRepository;
import artsoftconsult.study.repository.dbUtils.DbConnection;
import com.mysql.jdbc.Statement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Deprecated
@Repository
public class CategoryRepository extends HibernateRepository implements IRepository {

    @Autowired
    private DbConnection db;

    public Category findByTitle(String title) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM categories WHERE title=?")) {
            preStmt.setString(1, title);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(resultSet.getInt("categoryId"));
                category.setTitle(title);
                category.setUrl(resultSet.getString("url"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public Category findById(Integer id) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM categories WHERE categoryId=?")) {
            preStmt.setInt(1, id);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(id);
                category.setTitle(resultSet.getString("title"));
                category.setUrl(resultSet.getString("url"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }

    public Integer save(Category category) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO categories(title, url) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS)) {
            preStmt.setString(1, category.getTitle());
            preStmt.setString(2, category.getUrl());
            preStmt.executeUpdate();
            ResultSet rs = preStmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public boolean saveAssociation(Integer postID, Integer categoryID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO question_categories(postId, categoryId) VALUES (?,?)")) {
            preStmt.setInt(1, postID);
            preStmt.setInt(2, categoryID);
            preStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Integer[] findCategoryByPost(Integer postID) {
        List<Integer> list = new ArrayList<>();
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT categoryId FROM question_categories WHERE postId=?")) {
            preStmt.setInt(1, postID);
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                list.add(resultSet.getInt("categoryId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new Integer[0]);
    }

    public Integer[] findPostByCategory(Integer categoryId) {
        List<Integer> list = new ArrayList<>();
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT postId FROM question_categories WHERE categoryId=?")) {
            preStmt.setInt(1, categoryId);
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                list.add(resultSet.getInt("postId"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new Integer[0]);
    }

    public Category[] getAllCategories() {
        List<Category> list = new ArrayList<>();
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM categories")) {
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                Category tmp = new Category();
                tmp.setUrl(resultSet.getString("url"));
                tmp.setTitle(resultSet.getString("title"));
                tmp.setCategoryId(resultSet.getInt("categoryId"));
                list.add(tmp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new Category[0]);
    }
}
