<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Turf & Pool - Login/Sign Up</title>
    <style>
        :root {
            --primary-color: #1f9d68;
            --primary-dark: #14734b;
            --secondary-color: #142b2a;
            --muted-color: #6e817f;
            --surface-color: #fffdf8;
            --field-color: #f5f8f5;
            --line-color: #dbe7df;
        }

        * {
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            margin: 0;
            padding: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--secondary-color);
            font-family: Georgia, 'Times New Roman', serif;
            background:
                radial-gradient(circle at 12% 18%, rgba(255, 218, 112, 0.28) 0 9%, transparent 28%),
                radial-gradient(circle at 88% 84%, rgba(31, 157, 104, 0.3) 0 8%, transparent 30%),
                linear-gradient(135deg, #0d3b38 0%, #176c55 54%, #e5f0d3 54%, #f4f6e9 100%);
        }

        .auth-container {
            width: min(100%, 440px);
            padding: 42px 40px 40px;
            position: relative;
            overflow: hidden;
            text-align: center;
            background: var(--surface-color);
            border: 1px solid rgba(255, 255, 255, 0.7);
            border-radius: 24px;
            box-shadow: 0 24px 60px rgba(8, 45, 37, 0.24);
        }

        .auth-container::before {
            content: '';
            width: 110px;
            height: 110px;
            position: absolute;
            top: -58px;
            right: -25px;
            border: 18px solid rgba(239, 190, 62, 0.3);
            border-radius: 50%;
        }

        h2 {
            margin: 0 0 8px;
            color: var(--secondary-color);
            font-size: clamp(1.8rem, 5vw, 2.2rem);
            letter-spacing: -0.02em;
        }

        h2::after {
            content: '  &bull;  PLAY MORE. BOOK SMARTER.';
            display: block;
            margin-top: 10px;
            color: var(--primary-color);
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-size: 0.56rem;
            font-weight: 700;
            letter-spacing: 0.16em;
        }

        .tabs {
            display: flex;
            gap: 6px;
            margin: 30px 0 26px;
            padding: 5px;
            background: #edf3ed;
            border-radius: 12px;
        }

        .tab {
            flex: 1;
            padding: 11px 12px;
            cursor: pointer;
            color: var(--muted-color);
            border-radius: 8px;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-size: 0.9rem;
            font-weight: 700;
            transition: color 0.25s ease, background 0.25s ease, box-shadow 0.25s ease;
        }

        .tab:hover {
            color: var(--primary-dark);
        }

        .tab.active {
            color: var(--primary-dark);
            background: #fff;
            box-shadow: 0 3px 10px rgba(20, 115, 75, 0.12);
        }

        .form-group {
            margin-bottom: 18px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: var(--secondary-color);
            font-family: 'Segoe UI', Tahoma, sans-serif;
            font-size: 0.78rem;
            font-weight: 700;
            letter-spacing: 0.03em;
        }

        input, select {
            width: 100%;
            padding: 14px 15px;
            color: var(--secondary-color);
            background: var(--field-color);
            border: 1px solid var(--line-color);
            border-radius: 10px;
            outline: none;
            font: 0.95rem 'Segoe UI', Tahoma, sans-serif;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
        }

        input::placeholder {
            color: #9aaba5;
        }

        input:focus, select:focus {
            background: #fff;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(31, 157, 104, 0.13);
        }

        .btn-submit {
            width: 100%;
            margin-top: 8px;
            padding: 14px 18px;
            cursor: pointer;
            color: #fff;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            border: none;
            border-radius: 10px;
            font: 700 0.95rem 'Segoe UI', Tahoma, sans-serif;
            letter-spacing: 0.02em;
            box-shadow: 0 8px 16px rgba(20, 115, 75, 0.2);
            transition: transform 0.2s ease, box-shadow 0.2s ease, filter 0.2s ease;
        }

        .btn-submit:hover {
            filter: brightness(1.08);
            transform: translateY(-2px);
            box-shadow: 0 11px 22px rgba(20, 115, 75, 0.28);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* Hide the sign-up form initially */
        #signup-form { display: none; }

        /* OTP section hidden initially */
        #otp-form { display: none; }

        .alert {
            margin-top: 12px;
            padding: 12px;
            border-radius: 10px;
            font: 0.84rem 'Segoe UI', Tahoma, sans-serif;
        }
        .alert-success { background: #e2f4e6; color: #17633d; }
        .alert-danger { background: #fbe7e4; color: #9d3328; }

        @media (max-width: 520px) {
            body {
                padding: 16px;
            }

            .auth-container {
                padding: 32px 24px 28px;
                border-radius: 20px;
            }
        }
    </style>
</head>
<body>

<div class="auth-container">
    <h2 id="form-title">Welcome Back!</h2>
    
    <%
        String error = request.getParameter("error");
        String verified = request.getParameter("verified");
        String message = null;
        if ("invalid".equals(error)) message = "Invalid email or password.";
        else if ("exists".equals(error)) message = "An account with this email already exists.";
        else if ("email".equals(error)) message = "Unable to send OTP. Check Gmail App Password.";
        else if ("missing".equals(error)) message = "Please fill in all required fields.";
        else if ("login".equals(error)) message = "Please log in before booking a venue.";
        else if ("register".equals(error)) message = "Registration failed. Please try again.";
        else if ("session".equals(error)) message = "Your session expired. Please try again.";
    %>

    <% if (message != null) { %>
        <div class="alert alert-danger"><%= message %></div>
    <% } %>
    <% if ("true".equals(verified)) { %>
        <div class="alert alert-success">Email verified successfully. Please log in to continue.</div>
    <% } %>

    <div class="tabs">
        <div class="tab active" id="login-tab" onclick="showLogin()">Login</div>
        <div class="tab" id="signup-tab" onclick="showSignup()">Sign Up</div>
    </div>

    <!-- Login Form -->
    <form id="login-form" action="LoginServlet" method="post">
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="Enter your email" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>
        </div>
        <button type="submit" class="btn-submit">Login to Book</button>
    </form>

    <!-- Sign Up Form -->
    <form id="signup-form" action="RegisterServlet" method="post">
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="username" placeholder="John Doe" required>
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" name="email" placeholder="john@example.com" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Create password" required>
        </div>
        <div class="form-group">
            <label>Role</label>
            <select name="role">
                <option value="user">Sports Enthusiast (User)</option>
                <option value="business">Venue Owner (Business)</option>
            </select>
        </div>
        <button type="submit" class="btn-submit">Create Account</button>
    </form>

    <!-- OTP Verification Form -->
    <form id="otp-form" action="VerifyOtpServlet" method="post">
        <div class="form-group">
            <label>Enter OTP</label>
            <input type="text" name="otp" placeholder="6-digit code" required>
        </div>
        <button type="submit" class="btn-submit">Verify OTP</button>
        <% if (request.getParameter("error") != null) { %>
            <div class="alert alert-danger">Invalid OTP. Please try again.</div>
        <% } %>
        <% if (request.getParameter("verified") != null) { %>
            <div class="alert alert-success">Email verified successfully! You can now book venues.</div>
        <% } %>
    </form>
</div>

<script>
    function showLogin() {
        document.getElementById('login-form').style.display = 'block';
        document.getElementById('signup-form').style.display = 'none';
        document.getElementById('otp-form').style.display = 'none';
        document.getElementById('login-tab').classList.add('active');
        document.getElementById('signup-tab').classList.remove('active');
        document.getElementById('form-title').innerText = 'Welcome Back!';
    }

    function showSignup() {
        document.getElementById('login-form').style.display = 'none';
        document.getElementById('signup-form').style.display = 'block';
        document.getElementById('otp-form').style.display = 'none';
        document.getElementById('signup-tab').classList.add('active');
        document.getElementById('login-tab').classList.remove('active');
        document.getElementById('form-title').innerText = 'Join the Platform';
    }

    function showOtp() {
        document.getElementById('login-form').style.display = 'none';
        document.getElementById('signup-form').style.display = 'none';
        document.getElementById('otp-form').style.display = 'block';
        document.getElementById('form-title').innerText = 'Verify Your Email';
    }
</script>

</body>
</html>
