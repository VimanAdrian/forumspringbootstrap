package artsoftconsult.study.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by Viman Adrian on 20.10.2017.
 */
@Service("userDetailsService")
public class UserDetailsService extends JdbcDaoImpl {

    @Autowired
    private DataSource dataSource;

    @PostConstruct
    private void initialize() {
        setDataSource(dataSource);
    }

    @Override
    @Value("select * from users where username = ?")
    public void setUsersByUsernameQuery(String usersByUsernameQueryString) {
        super.setUsersByUsernameQuery(usersByUsernameQueryString);
    }

    @Override
    @Value("select username, role from users where username =?")
    public void setAuthoritiesByUsernameQuery(String queryString) {
        super.setAuthoritiesByUsernameQuery(queryString);
    }

    //override to get accountNonLocked
    @Override
    public List<UserDetails> loadUsersByUsername(String username) {
        return getJdbcTemplate().query(super.getUsersByUsernameQuery(), new String[]{username},
                new RowMapper<UserDetails>() {
                    public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                        String username = rs.getString("username");
                        String password = rs.getString("password");
                        boolean enabled = rs.getBoolean("enabled");
                        boolean accountNonExpired = true;
                        boolean credentialsNonExpired = true;
                        boolean accountNonLocked = rs.getBoolean("account_non_locked");

                        return new User(username, password, enabled, accountNonExpired, credentialsNonExpired,
                                accountNonLocked, AuthorityUtils.NO_AUTHORITIES);
                    }
                });
    }

    //override to pass accountNonLocked
    @Override
    public UserDetails createUserDetails(String username, UserDetails userFromUserQuery,
                                         List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();

        if (super.isUsernameBasedPrimaryKey()) {
            returnUsername = username;
        }

        return new User(returnUsername, userFromUserQuery.getPassword(),
                userFromUserQuery.isEnabled(),
                userFromUserQuery.isAccountNonExpired(),
                userFromUserQuery.isCredentialsNonExpired(),
                userFromUserQuery.isAccountNonLocked(), combinedAuthorities);
    }

}