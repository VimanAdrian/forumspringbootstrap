package artsoftconsult.study.utils;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Component
public class Email {
    private JavaMailSender mailSender;

    public Email() {
        JavaMailSenderImpl sender = new JavaMailSenderImpl();
        sender.setProtocol("smtp");
        sender.setHost("smtp.gmail.com");
        sender.setPort(587);
        sender.setUsername("forumspringartsoft@gmail.com");
        sender.setPassword("parolaForum");

        Properties mailProps = new Properties();
        mailProps.put("mail.smtps.auth", "true");
        mailProps.put("mail.smtp.starttls.enable", "true");
        mailProps.put("mail.smtp.debug", "true");
        sender.setJavaMailProperties(mailProps);
        this.mailSender = sender;
    }

    public void sendActivationEmail(String email, String name, String activateUrl) {
        try {
            String msg = "<p>Hello " + name + "</p>"
                    + "<p>You recently made an account at <a href='http://localhost:8080'>http://localhost:8080</a>.</p>"
                    + "<p>You need to activate your account by clicking this link: <a href='" + activateUrl + "'>" + activateUrl + "</a>.</p>"
                    + "<p>Thank you.</p>";

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("New account");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("forumspringartsoft@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendPasswordResetEmail(String email, String name, String resetUrl) {
        try {
            String msg = "<p>Hello " + name + "</p>"
                    + "<p>You recently made a password reset request at <a href='http://localhost:8080'>http://localhost:8080</a>.</p>"
                    + "<p>You can reset your password by clicking this link: <a href='" + resetUrl + "'>" + resetUrl + "</a>.</p>"
                    + "<p>Thank you.</p>";

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("Password reset");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("forumspringartsoft@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void sendNewReplyEmain(String email, String name, String postPage, String replyContent) {
        try {
            String msg = "<p>Hello " + name + "</p>"
                    + "<p>Someone recently replied to your <a href='" + postPage + "'>question</a>.</p>"
                    + "<p>This is what they said: '" + replyContent + "'.</p>"
                    + "<p>Thank you.</p>";

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("New reply");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("forumspringartsoft@gmail.com");
            helper.setTo(email);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    public void sendAccountLockedEmail(String userEmail, String username) {
        try {
            String msg = "<p>Hello " + username + "</p>"
                    + "<p>Your account was locked because someone failed to login 3 times in a row.</p>"
                    + "<p>Thank you.</p>";

            MimeMessage message = mailSender.createMimeMessage();
            message.setSubject("Account locked");

            MimeMessageHelper helper;
            helper = new MimeMessageHelper(message, true);
            helper.setFrom("forumspringartsoft@gmail.com");
            helper.setTo(userEmail);
            helper.setText(msg, true);
            mailSender.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
