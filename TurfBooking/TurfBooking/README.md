# TurfBook — Java Servlet/JSP + MySQL

A sports facility booking application for football/cricket turfs and other venues.

## Fixed in this version

- Fixed UTF-8/mojibake characters such as `â‚¹`, `â†’`, `â€¢` by using UTF-8 JSP directives and safe HTML entities.
- Added proper booking error messages.
- Added server-side validation for booking date/time.
- Prevents booking an already-booked venue slot.
- Fixed the database schema mismatch: `price_per_hour`, `image_url`, and `booking_time` are now part of the schema.
- Added price and image-path fields to the Venue Owner form.
- Added login/registration error messages.
- Added a complete Windows `RUN_TURFBOOKING.bat` that compiles the Java source and deploys the webapp to Tomcat.
- Kept MySQL password configuration compatible with the current local setup.

## Requirements

- JDK 21 or newer
- MySQL Server
- Apache Tomcat 10.1.x
- VS Code (optional)
- Gmail App Password if OTP email is required

## Database setup

1. Start MySQL.
2. Open `TurfBooking/TurfBookingDB.sql` in MySQL Workbench.
3. Run the full script.
4. Verify:

```sql
USE turfbookingdb;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM venues;
SELECT * FROM bookings;
```

The current local Java configuration uses:

- Database: `turfbookingdb`
- Port: `3306`
- User: `root`

If your MySQL root password is different, update `DBConnection.java`.

## Easiest Windows run

1. Make sure MySQL is running.
2. Set `JAVA_HOME` to your JDK folder.
3. For OTP email, create a Gmail App Password and set:

```text
TURF_GMAIL_APP_PASSWORD=your_app_password
```

4. Double-click:

```text
TurfBooking/RUN_TURFBOOKING.bat
```

5. Open:

```text
http://localhost:8080/TurfBooking/
```

To stop Tomcat, run:

```text
TurfBooking/STOP_TURFBOOKING.bat
```

## VS Code / Community Server Connectors

If you use VS Code instead of the batch file:

1. Open the folder containing `.project`, `.classpath`, `src`, and `README.md`.
2. Add Tomcat 10.1.x in Community Server Connectors.
3. Deploy the `TurfBooking` project.
4. If old JSP output still shows characters such as `â‚¹` or `â†’`, stop Tomcat and clear its `work/Catalina/localhost/TurfBooking` cache, then redeploy.
5. Make sure the project is compiled with UTF-8.

## Gmail OTP

The sender account is configured in `EmailUtil.java`.

The Gmail App Password is intentionally read from the `TURF_GMAIL_APP_PASSWORD` environment variable instead of being stored in source code.

## Important GitHub warning

Before publishing this project publicly, move the MySQL password out of `DBConnection.java` and into an environment variable. Never commit real database passwords or Gmail App Passwords to GitHub.

The current password-based login also stores user passwords as plain text. For a production version, replace this with a salted password-hashing algorithm such as PBKDF2/BCrypt/Argon2.
