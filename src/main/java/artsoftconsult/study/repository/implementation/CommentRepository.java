package artsoftconsult.study.repository.implementation;

import artsoftconsult.study.repository.dbUtils.DbConnection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CommentRepository {

    @Autowired
    private DbConnection db;
    @Autowired
    private UserRepository userRepository;


    public PostComment[] findByPostId(int postID) {
        List<PostComment> list = new ArrayList<>();
        Connection con = db.getConnection();
        try (PreparedStatement preSmt = con.prepareStatement("SELECT * FROM question_comments WHERE postID = ? ")) {
            preSmt.setInt(1, postID);
            ResultSet resultSet = preSmt.executeQuery();
            while(resultSet.next()){
                PostComment p = new PostComment();
                p.setCommentId(resultSet.getInt("commentID"));
                p.setUser(userRepository.findById(resultSet.getInt("userID")));
                p.setContent(resultSet.getString("content"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new PostComment[0]);
    }


    public ReplyComment[] findByReplyId(int replyId) {
        List<ReplyComment> list = new ArrayList<>();
        Connection con = db.getConnection();
        try (PreparedStatement preSmt = con.prepareStatement("SELECT * FROM replies_comments WHERE replyID = ? ")) {
            preSmt.setInt(1, replyId);
            ResultSet resultSet = preSmt.executeQuery();
            while(resultSet.next()){
                ReplyComment p = new ReplyComment();
                p.setCommentId(resultSet.getInt("commentID"));
                p.setUser(userRepository.findById(resultSet.getInt("userID")));
                p.setContent(resultSet.getString("content"));
                list.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list.toArray(new ReplyComment[0]);
    }
}
