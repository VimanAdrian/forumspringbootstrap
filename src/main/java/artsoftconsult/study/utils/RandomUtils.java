package artsoftconsult.study.utils;

import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.security.SecureRandom;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class RandomUtils {

    private static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    private static SecureRandom rnd = new SecureRandom();

    public static String[] split(String string) {
        return string.split("\\s+");
    }

    public static String randomString(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++)
            sb.append(AB.charAt(rnd.nextInt(AB.length())));
        return sb.toString();
    }

    public static String generateFileName(String originalFileName) {
        String[] EXTENSIONS = new String[]{".gif", ".png", ".bmp", ".jpg"};
        DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Date date = new Date();
        String extension = ".png";
        for (String ext : EXTENSIONS) {
            if (originalFileName.endsWith(ext))
                extension = ext;
        }
        return dateFormat.format(date) + RandomUtils.randomString(10) + extension;
    }

}
