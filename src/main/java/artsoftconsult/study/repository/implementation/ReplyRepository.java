package artsoftconsult.study.repository.implementation;

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
import java.util.List;

@Deprecated
@Repository
public class ReplyRepository extends HibernateRepository implements IRepository {

    @Autowired
    private DbConnection db;

    @Autowired
    private UserRepository userRepository;

    public ReplyRepository() {
    }

    public boolean save(Reply reply) {
        Connection con = db.getConnection();
        User user = new User();
        user.setUserId(userRepository.findId(reply.getUser().getUsername()));
        reply.setUser(user);
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO replies(postID, userID, content, creationDate) VALUES(?,?,?,?)")) {
            preStmt.setInt(1, reply.getPost().getPostId());
            preStmt.setInt(2, reply.getUser().getUserId());
            preStmt.setString(3, reply.getContent());
            preStmt.setTimestamp(4, reply.getCreationDate());
            preStmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Reply[] findByPostId(Integer postID, Integer page, User currentUser) {
        Connection con = db.getConnection();
        List<Reply> list = new ArrayList<>();
        String select;
        if (!currentUser.getAdmin())
            select = "SELECT * FROM replies WHERE postID=? AND enabled='1' LIMIT ?,?";
        else
            select = "SELECT * FROM replies WHERE postID=? LIMIT ?,?";
        try (PreparedStatement preStmt = con.prepareStatement(select)) {
            preStmt.setInt(1, postID);
            preStmt.setInt(2, page * 20);
            preStmt.setInt(3, 20);
            ResultSet resultSet = preStmt.executeQuery();
            while (resultSet.next()) {
                Reply tmp = new Reply();
                tmp.setReplyId(resultSet.getInt("replyId"));
                tmp.setUser(userRepository.findById(resultSet.getInt("userID")));
                tmp.setBestAnswer(resultSet.getByte("bestAnswer"));
                tmp.setContent(resultSet.getString("content"));
                tmp.setCreationDate(resultSet.getTimestamp("creationDate"));
                tmp.setScore(resultSet.getInt("score"));
                tmp.setEnabled(resultSet.getByte("enabled"));
                tmp.setReplyVoteType(voteType(tmp.getReplyId(), userRepository.findByUsername(currentUser.getUsername()).getUserId()));
                list.add(tmp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new Reply[0]);
    }

    public Reply bestReply(Integer postID, Integer currentUserID) {
        Connection con = db.getConnection();
        Reply tmp = new Reply();
        tmp.setReplyId(-1);
        try (PreparedStatement preStmt = con.prepareStatement("SELECT * FROM replies WHERE postID=? AND bestAnswer=1")) {
            preStmt.setInt(1, postID);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                tmp.setReplyId(resultSet.getInt("replyId"));
                tmp.setUser(userRepository.findById(resultSet.getInt("userID")));
                tmp.setBestAnswer(resultSet.getByte("bestAnswer"));
                tmp.setContent(resultSet.getString("content"));
                tmp.setCreationDate(resultSet.getTimestamp("creationDate"));
                tmp.setScore(resultSet.getInt("score"));
                tmp.setEnabled(resultSet.getByte("enabled"));
                tmp.setReplyVoteType(voteType(tmp.getReplyId(), currentUserID));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tmp;
    }

    public Integer voteType(Integer replyID, Integer userID) {
        //System.out.println(userID);
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT voteType FROM votes_users_replies WHERE userID=? AND replyID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyID);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Integer postNrPages(Integer postID, boolean currentUser) {
        Connection con = db.getConnection();
        String select;
        if (!currentUser)
            select = "SELECT COUNT(replyId) FROM replies WHERE postID=? AND enabled='1'";
        else
            select = "SELECT COUNT(replyId) FROM replies WHERE postID=?";
        try (PreparedStatement statement = con.prepareStatement(select)) {
            statement.setInt(1, postID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Integer hasVote(Integer replyID, Integer userID) {
        Connection con = db.getConnection();
        try (PreparedStatement preStmt = con.prepareStatement("SELECT voteType FROM votes_users_replies WHERE userID=? AND replyID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyID);
            ResultSet resultSet = preStmt.executeQuery();
            if (resultSet.next())
                return resultSet.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean vote(Integer replyId, Integer userID, Integer voteType) {
        Connection con = db.getConnection();
        boolean badVote = false;
        try {
            con.setAutoCommit(false);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("SELECT voteType FROM votes_users_replies WHERE userID=? AND replyID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyId);
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
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM votes_users_replies WHERE userID=? AND replyID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyId);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET score = score + ? WHERE replyId = ?")) {
            preparedStatement.setInt(1, voteType);
            preparedStatement.setInt(2, replyId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO votes_users_replies(userID, replyID, voteType) VALUES (?,?,?)")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyId);
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

    /*
    public boolean vote(Integer replyId, Integer userID, Integer vote) {
        Connection con = db.getConnection();
        try {
            con.setAutoCommit(false);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("DELETE FROM votes_users_replies WHERE userID=? AND replyID=?")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyId);
            preStmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET score = score + ? WHERE replyId = ?")) {
            preparedStatement.setInt(1, vote);
            preparedStatement.setInt(2, replyId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try (PreparedStatement preStmt = con.prepareStatement("INSERT INTO votes_users_replies(userID, replyID, voteType) VALUES (?,?,?)")) {
            preStmt.setInt(1, userID);
            preStmt.setInt(2, replyId);
            preStmt.setInt(3, vote);
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
    */
    public boolean favorite(Integer replyID, Integer postID) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET bestAnswer='0' WHERE postID=?")) {
            preparedStatement.setInt(1, postID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        try (PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET bestAnswer='1' WHERE replyId=?")) {
            preparedStatement.setInt(1, replyID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean toggleStatus(Integer replyId) {
        Connection con = db.getConnection();
        try (PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET enabled=NOT(enabled) WHERE replyId = ?")) {
            preparedStatement.setInt(1, replyId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public boolean updateContent(Reply reply){
        Connection con = db.getConnection();
        try(PreparedStatement preparedStatement = con.prepareStatement("UPDATE replies SET content = ? WHERE replyId = ?")){
            preparedStatement.setInt(2,reply.getReplyId());
            preparedStatement.setString(1,reply.getContent());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
