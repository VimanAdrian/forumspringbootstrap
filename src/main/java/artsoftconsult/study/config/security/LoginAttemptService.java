package artsoftconsult.study.config.security;

import artsoftconsult.study.service.UserService;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

/**
 * Created by Viman Adrian on 12.10.2017.
 */
@Component
public class LoginAttemptService {

    private final int MAX_ATTEMPT = 3;

    @Autowired
    private UserService userService;

    private LoadingCache<String, Integer> attemptsCache;

    public LoginAttemptService() {
        attemptsCache = CacheBuilder.newBuilder().
                expireAfterWrite(1, TimeUnit.DAYS).build(new CacheLoader<String, Integer>() {
            public Integer load(String key) {
                return 0;
            }
        });
    }

    public void loginSucceeded(String key) {
        attemptsCache.invalidate(key);
    }

    public void loginFailed(String key) {
        int attempts = 0;
        try {
            attempts = attemptsCache.get(key);
        } catch (ExecutionException e) {
            attempts = 0;
        }
        attempts++;
        attemptsCache.put(key, attempts);
//        System.out.println("loginFailed "+ "key: " + key + " attempts: "+attempts);
        block(key);
    }

    public void block(String key) {
        try {
            if (attemptsCache.get(key) >= MAX_ATTEMPT) {
                userService.block(key);
            }
        } catch (ExecutionException e) {
            e.printStackTrace();
        }
    }
}