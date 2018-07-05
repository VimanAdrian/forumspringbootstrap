package artsoftconsult.study.repository;

public interface TokenRepositoryCustom {

    boolean saveToken(Long userId, String token);

    boolean deleteToken(Long userId);

    long findToken(String token, Long userId);

    boolean deletePasswordReset(Long userId);

    boolean savePasswordReset(Long userId, String token);

    Long findPasswordResetToken(String token, Long userId);

}
