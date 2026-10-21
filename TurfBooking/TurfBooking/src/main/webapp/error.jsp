<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>TurfBook | Error</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    min-height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
    font-family:Arial, sans-serif;
    background:#07140e;
}

.card{
    width:480px;
    max-width:92%;
    background:white;
    border-radius:25px;
    padding:50px 40px;
    text-align:center;
    box-shadow:0 30px 70px rgba(0,0,0,.45);
}

.logo{
    font-size:26px;
    font-weight:800;
    color:#20a75c;
    margin-bottom:30px;
}

.icon{
    width:85px;
    height:85px;
    margin:auto;
    display:flex;
    justify-content:center;
    align-items:center;
    background:#fff0ef;
    color:#e74c3c;
    border-radius:50%;
    font-size:42px;
}

h1{
    margin:22px 0 10px;
    color:#18231e;
    font-size:28px;
}

p{
    color:#78847d;
    font-size:14px;
    line-height:1.6;
}

a{
    display:block;
    margin-top:25px;
    padding:14px;
    border-radius:11px;
    background:#183d29;
    color:white;
    text-decoration:none;
    font-weight:bold;
    transition:.3s;
}

a:hover{
    background:#20a75c;
}

.help{
    margin-top:20px;
    font-size:12px;
    color:#a0aaa5;
}

</style>

</head>

<body>

<div class="card">

    <div class="logo">
        TurfBook
    </div>

    <div class="icon">
        !
    </div>

    <h1>
        Something Went Wrong
    </h1>

    <p>
        We couldn't complete your request right now.
        Please try again. If the problem continues,
        contact support.
    </p>

    <a href="login.jsp">
        &larr; Back to Login
    </a>

    <div class="help">
        TurfBook Support &bull; We're here to help
    </div>

</div>

</body>

</html>