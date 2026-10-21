<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>TurfBook | Verify Email</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    font-family:Arial, sans-serif;
    background:
        radial-gradient(circle at 20% 20%,#1d7448,transparent 30%),
        #07140e;
}

.card{
    width:430px;
    max-width:92%;
    background:white;
    padding:45px 40px;
    border-radius:25px;
    text-align:center;
    box-shadow:0 30px 70px rgba(0,0,0,.4);
}

.logo{
    font-size:26px;
    font-weight:800;
    color:#20a75c;
    margin-bottom:30px;
}

.icon{
    width:75px;
    height:75px;
    margin:auto;
    display:flex;
    align-items:center;
    justify-content:center;
    border-radius:50%;
    background:#e8f8ef;
    font-size:35px;
}

h2{
    color:#16251d;
    margin:22px 0 10px;
}

.subtitle{
    color:#7a8780;
    font-size:14px;
    line-height:1.6;
}

.otp{
    width:100%;
    padding:16px;
    margin:25px 0 15px;
    border:2px solid #e0e7e3;
    border-radius:12px;
    text-align:center;
    font-size:24px;
    letter-spacing:10px;
    outline:none;
}

.otp:focus{
    border-color:#20a75c;
    box-shadow:0 0 0 4px rgba(32,167,92,.1);
}

button{
    width:100%;
    padding:15px;
    border:0;
    border-radius:12px;
    background:#183d29;
    color:white;
    font-size:15px;
    font-weight:bold;
    cursor:pointer;
}

button:hover{
    background:#20a75c;
}

.error{
    background:#fff0f0;
    color:#c0392b;
    padding:12px;
    border-radius:10px;
    font-size:13px;
    margin-top:15px;
}

</style>

</head>

<body>

<div class="card">

    <div class="logo">
        TurfBook
    </div>

    <div class="icon">
        &#9993;
    </div>

    <h2>Verify Your Email</h2>

    <p class="subtitle">
        We've sent a verification code to your email.
        Enter the OTP below to continue.
    </p>


<%
String error = request.getParameter("error");

if(error != null){

%>

    <div class="error">

<%
    if("invalid".equals(error)){
        out.print("Invalid OTP. Please try again.");
    }
    else if("notverified".equals(error)){
        out.print("You must verify OTP before logging in.");
    }
    else{
        out.print("Verification failed. Please try again.");
    }
%>

    </div>

<%
}
%>


    <form
        action="VerifyOtpServlet"
        method="post">

        <input
            class="otp"
            type="text"
            name="otp"
            maxlength="6"
            pattern="[0-9]{6}"
            inputmode="numeric"
            placeholder="000000"
            required>

        <button type="submit">
            Verify OTP &rarr;
        </button>

    </form>

</div>

</body>

</html>