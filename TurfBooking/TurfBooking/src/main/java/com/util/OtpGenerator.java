package com.util;
import java.util.Random;

public class OtpGenerator {
    public static String generateOtp() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // 6-digit OTP
        return String.valueOf(otp);
    }
}
