package artsoftconsult.study.repository.dbUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@Component
public class DbConnection {

    private static Connection instance = null;

    private String driver = null;

    @Autowired
    private Environment env;

    private String url = null;
    private String username = null;
    private String password = null;

    private void getMySQLConnection() throws SQLException, ClassNotFoundException {
        driver = "com.mysql.jdbc.Driver";
        url = "jdbc:mysql://localhost:3306/forum";
        username = "java";
        password = "password";
        Connection con = null;
        if (instance == null || instance.isClosed()) {
            Class.forName(driver);
            instance = DriverManager.getConnection(url, username, password);
            //System.out.println("Database connected!");
        }
    }

    private void getSqLiteConnection() throws SQLException, ClassNotFoundException {
        driver = "org.sqlite.JDBC";
        Connection con = null;
        if (instance == null || instance.isClosed()) {
            Class.forName(driver);
            instance = DriverManager.getConnection(env.getProperty("databaseURL"));
            //System.out.println("Database connected!");
        }
    }

    public Connection getConnection() {
        try {
            //System.out.println("Getting mysql connection");
            getSqLiteConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return instance;
    }
}