package com.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailUtil {
    private static final String FROM_EMAIL = "danushsd1506@gmail.com";
    // Create a Gmail App Password for this account and set it as TURF_GMAIL_APP_PASSWORD.
    private static final String APP_PASSWORD = System.getenv("TURF_GMAIL_APP_PASSWORD");

    private static Session createMailSession() {
        if (APP_PASSWORD == null || APP_PASSWORD.isBlank()) {
            throw new IllegalStateException("TURF_GMAIL_APP_PASSWORD is not set. Create a Gmail App Password and set this environment variable.");
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });
    }

    public static boolean sendOtpEmail(String toEmail, String otp) {
        try {
            Session session = createMailSession();
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Your Turf & Pool OTP Verification Code");
            msg.setText("Your OTP code is: " + otp + "\n\nPlease enter this code to verify your email.");
            Transport.send(msg);
            System.out.println("OTP email sent to " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Unable to send OTP email: " + e.getMessage());
            return false;
        }
    }

    public static boolean sendConfirmationEmail(String recipientEmail, String messageText) {
        try {
            Session session = createMailSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Turf & Pool Booking Confirmation");
            message.setText(messageText);
            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("Unable to send confirmation email: " + e.getMessage());
            return false;
        }
    }
}
