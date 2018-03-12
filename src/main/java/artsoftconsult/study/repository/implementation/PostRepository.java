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

@Repository
public class PostRepository extends HibernateRepository implements IRepository {

    @Autowired
    private DbConnection db;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ReplyRepository replyRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private CommentRepository commentRepository;

    public PostRepository() {

    }

    public Integer save(Post post) {
        Connection con = db.getConnection();
        User user = new User();
        user.setUserId(userRepository.findId(post.getUser().getUsername()));
        post.setUser(user);
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO question(userID, title, content) VALUES(?,?,?)", Statement.RETURN_GENERATED_KEYS)) {
            preStmt.setInt(1, post.getUser().getUserId());
            preStmt.setString(2, post.getTitle());
            preStmt.setString(3, post.getContent());
            preStmt.executeUpdate();
            ResultSet rs = preStmt.getGeneratedKeys();
            if (rs.next()) {
                Integer postID = rs.getInt(1);
                for (Category category : post.getCategories()) {
                    Category cat = categoryRepository.findByTitle(category.getTitle());
                    if (cat == null) {
                        Integer categoryID = categoryRepository.save(category);
                        if (categoryID != -1) {
                            categoryRepository.saveAssociation(postID, categoryID);
                        }
                    } else {
                        categoryRepository.saveAssociation(postID, cat.getCategoryId());
                    }
                }
                return postID;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public void incrementView(Integer postID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE question SET views = views + 1 WHERE questioID=?")) {
            preStmt.setInt(1, postID);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Post[] search(String[] searchString, Integer page, boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT * FROM question WHERE active='1' AND title LIKE ? LIMIT ?,?";
        else
            select = "SELECT * FROM question WHERE active='0' AND title LIKE ? LIMIT ?,?";
        for (String searchTerm : searchString) {
            try (PreparedStatement preStmt = con.prepareStatement(select)) {
                preStmt.setString(1, "%" + searchTerm + "%");
                preStmt.setInt(2, page * 20);
                preStmt.setInt(3, 20);
                return search(preStmt);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return new Post[0];
    }


    public Post[] search(Integer page, boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT * FROM question WHERE active='1' LIMIT ?,?";
        else
            select = "SELECT * FROM question WHERE active='0' LIMIT ?,?";
        try (PreparedStatement preStmt = con.prepareStatement(select)) {
            preStmt.setInt(1, page * 20);
            preStmt.setInt(2, 20);
            return search(preStmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new Post[0];
    }

    public Post[] searchByTag(String tag, Integer page, boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT * FROM question WHERE active='1' AND questioID IN (SELECT questioID FROM question_categories WHERE categoryId = (SELECT categoryId FROM categories WHERE categories.title=?)) LIMIT ?,?";
        else
            select = "SELECT * FROM question WHERE active='0' AND questioID IN (SELECT questioID FROM question_categories WHERE categoryId = (SELECT categoryId FROM categories WHERE categories.title=?)) LIMIT ?,?";
        try (PreparedStatement preStmt = con.prepareStatement(select)) {
            preStmt.setString(1, tag);
            preStmt.setInt(2, page * 20);
            preStmt.setInt(3, 20);
            return search(preStmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new Post[0];
    }

    private Post[] search(PreparedStatement preStmt) {
        List<Post> list = new ArrayList<>();
        try {
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                Post post = new Post();
                User user = new User();
                Integer userID = -1;
                List<Category> categoryList = new ArrayList<>();
                post.setPostId(resultSet.getInt("postID"));
                post.setTitle(resultSet.getString("title"));
                post.setContent(resultSet.getString("content"));
                post.setCreationDate(resultSet.getTimestamp("creationDate"));
                post.setViews(resultSet.getInt("views"));
                post.setScore(resultSet.getInt("score"));
                post.setActive(resultSet.getByte("active"));
                userID = resultSet.getInt("userID");
                user = userRepository.findById(userID);
                post.setUser(user);
                for (Integer id : categoryRepository.findCategoryByPost(resultSet.getInt("postID"))) {
                    categoryList.add(categoryRepository.findById(id));
                }
                post.setCategories(categoryList.toArray(new Category[0]));
                if (!list.contains(post))
                    list.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new Post[0]);
    }

    public Post find(Integer postID, User currentUser, Integer page) {
        Connection con = db.getConnection();
        if (currentUser.getAdmin()) {
            try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM question WHERE questioID=?")) {
                preStmt.setInt(1, postID);
                return find(preStmt, currentUser, page);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM question WHERE questioID=? AND active='1'")) {
                preStmt.setInt(1, postID);
                return find(preStmt, currentUser, page);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public Integer findPoster(Integer postID) {
        Connection con = db.getConnection();
        try (PreparedStatement preSmt = con.prepareStatement("SELECT userID FROM question WHERE questioID=?")) {
            preSmt.setInt(1, postID);
            ResultSet resultSet = preSmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    private Post find(PreparedStatement preparedStatement, User currentUser, Integer page) throws SQLException {
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            Post post = new Post();
            User user;
            Integer userID;
            List<Category> categoryList = new ArrayList<>();
            post.setPostId(resultSet.getInt("postID"));
            post.setTitle(resultSet.getString("title"));
            post.setContent(resultSet.getString("content"));
            post.setCreationDate(resultSet.getTimestamp("creationDate"));
            post.setViews(resultSet.getInt("views"));
            post.setScore(resultSet.getInt("score"));
            post.setActive(resultSet.getByte("active"));
            userID = resultSet.getInt("userID");
            user = userRepository.findById(userID);
            post.setUser(user);
            post.setReplies(replyRepository.findByPostId(resultSet.getInt("postID"), page, currentUser));
            post.setComments(commentRepository.findByPostId(resultSet.getInt("postID")));
            for (Integer id : categoryRepository.findCategoryByPost(resultSet.getInt("postID"))) {
                categoryList.add(categoryRepository.findById(id));
            }
            post.setCategories(categoryList.toArray(new Category[0]));
            return post;
        }
        return null;
    }

    public Integer searchNext(String[] searchString, boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT COUNT(questioID) FROM question WHERE title LIKE ? AND active='1' ";
        else
            select = "SELECT COUNT(questioID) FROM question WHERE title LIKE ? AND active='0'";
        for (String searchTerm : searchString) {
            try (PreparedStatement preStmt = con.prepareStatement(select)) {
                preStmt.setString(1, "%" + searchTerm + "%");
                ResultSet resultSet = preStmt.executeQuery();
                if (resultSet.next())
                    return resultSet.getInt(1);
            } catch (SQLException e) {
                e.printStackTrace();
                return -1;
            }
        }
        return -1;
    }


    public Integer searchNext(boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT COUNT(questioID) FROM question WHERE active='1'";
        else
            select = "SELECT COUNT(questioID) FROM question WHERE active='0'";
        try (PreparedStatement preStmt = con.prepareStatement(select)) {
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public Integer searchByTagNext(String tag, boolean disabled) {
        Connection con = db.getConnection();
        String select;
        if (!disabled)
            select = "SELECT COUNT(questioID) FROM question WHERE active='1' AND questioID IN (SELECT questioID FROM question_categories WHERE categoryId = (SELECT categoryId FROM categories WHERE categories.title=?))";
        else
            select = "SELECT COUNT(questioID) FROM question WHERE active='0' AND questioID IN (SELECT questioID FROM question_categories WHERE categoryId = (SELECT categoryId FROM categories WHERE categories.title=?))";
        try (PreparedStatement preStmt = con.prepareStatement(select)) {
            preStmt.setString(1, tag);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public Integer hasVote(Integer postID, Integer userID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT voteType FROM votes_users_posts WHERE userID=? AND postID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, postID);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean vote(Integer postID, Integer userID, Integer voteType) {
        Connection con = db.getConnection();
        boolean badVote = false;
        try {
            con.setAutoCommit(false);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("SELECT voteType FROM votes_users_posts WHERE userID=? AND postID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, postID);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                if (resultSet.getInt(1) == voteType)
                    badVote = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (badVote) {
            try {
                con.commit();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return false;
        }
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM votes_users_posts WHERE userID=? AND postID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, postID);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE question SET score=score+? WHERE questioID=?")) {
            preStmt.setInt(1, voteType);
            preStmt.setInt(2, postID);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO votes_users_posts(userID, postID, voteType) VALUES (?,?,?)")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, postID);
            preStmt.setInt(3, voteType);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            con.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean togglePostStatus(Integer postID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("UPDATE question SET active=NOT(active) WHERE questioID=?")) {
            preStmt.setInt(1, postID);
            preStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isAdmin(String username) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT role FROM users WHERE username=?")) {
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                return (resultSet.getString("role").equals("ROLE_ADMIN"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Post[] searchByUser(Integer userID, Integer page, boolean disabled) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT * FROM question WHERE userID=? AND active=? LIMIT ?, ?")) {
            preparedStatement.setInt(1, userID);
            preparedStatement.setBoolean(2, !disabled);
            preparedStatement.setInt(3, page * 20);
            preparedStatement.setInt(4, 20);
            return search(preparedStatement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new Post[0];
    }


    public Integer searchByUserNext(Integer userID, boolean disabled) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("SELECT COUNT(questioID) FROM question WHERE userID=? AND active=?")) {
            preparedStatement.setInt(1, userID);
            preparedStatement.setBoolean(2, !disabled);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        return -1;
    }

    public void update(Post post) {
        Connection con = db.getConnection();
        try (PreparedStatement prestmt = con.prepareStatement("UPDATE question SET title=IFNULL(?, title), content=IFNULL(?, content) WHERE questioID=?")) {
            prestmt.setString(1, post.getTitleForUpdate());
            prestmt.setString(2, post.getContentForUpdate());
            prestmt.setInt(3, post.getPostId());
            prestmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Post> newReplies(User user) {
        Connection con = db.getConnection();
        List<Post> list = new ArrayList<>();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT postID FROM users_new_reply WHERE userID=? LIMIT 5")) {
            preStmt.setInt(1, user.getUserId());
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                Integer postId = resultSet.getInt(1);
                try (PreparedStatement preStmt2 = con.prepareStatement("SELECT title FROM question WHERE questioID=?")) {
                    preStmt2.setInt(1, postId);
                    ResultSet resultSet2 = preStmt2.executeQuery();
                    if (resultSet2.next()) {
                        Post post = new Post();
                        post.setPostId(postId);
                        post.setTitle(resultSet2.getString(1));
                        list.add(post);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> topPosts(User user){
        List<Post> arrayList = new ArrayList<>();
        Connection con = db.getConnection();
        List<Post> list = new ArrayList<>();
        try(PreparedStatement prestmt = con.prepareStatement("SELECT * FROM question WHERE userID=? ORDER BY score DESC LIMIT 5;")){
            prestmt.setInt(1,user.getUserId());
            ResultSet resultSet = prestmt.executeQuery();
            while(resultSet.next()){
                Post post = new Post();
                post.setTitle(resultSet.getString("title"));
                post.setPostId(resultSet.getInt("postID"));
                post.setScore(resultSet.getInt("score"));
                arrayList.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return arrayList;
    }

    public void markNotNew(String postID, User currentUser) {
        Connection con = db.getConnection();
        try(PreparedStatement preStmt = con.prepareStatement("DELETE FROM users_new_reply WHERE postID=? AND userID=?")) {
            preStmt.setInt(1, Integer.parseInt(postID));
            preStmt.setInt(2,currentUser.getUserId());
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
