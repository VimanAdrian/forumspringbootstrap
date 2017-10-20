package artsoftconsult.study.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.security.authentication.event.AuthenticationFailureBadCredentialsEvent;
import org.springframework.stereotype.Component;


/**
 * Created by Viman Adrian on 15.10.2017.
 */
@Component
public class AuthenticationFailureListener implements ApplicationListener<AuthenticationFailureBadCredentialsEvent> {

    @Autowired
    private LoginAttemptService loginAttemptService;

    @Override
    public void onApplicationEvent(final AuthenticationFailureBadCredentialsEvent event) {
        String username = event.getAuthentication().getName();
        if (username != null) {
            loginAttemptService.loginFailed(username);
        }
    }

}