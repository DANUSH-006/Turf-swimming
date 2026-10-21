<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>TurfBook | Booking Confirmed</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    min-height:100vh;
    font-family:Arial, sans-serif;
    display:flex;
    align-items:center;
    justify-content:center;
    background:
        radial-gradient(circle at 15% 20%,#1d7147,transparent 30%),
        radial-gradient(circle at 85% 80%,#163f2b,transparent 30%),
        #07140e;
}

.card{
    width:500px;
    max-width:92%;
    background:white;
    border-radius:28px;
    padding:50px 40px;
    text-align:center;
    box-shadow:0 30px 80px rgba(0,0,0,.45);
}

.check{
    width:90px;
    height:90px;
    margin:0 auto 25px;
    border-radius:50%;
    background:#dff8e9;
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:45px;
    animation:pop .5s ease;
}

@keyframes pop{

    0%{
        transform:scale(.4);
        opacity:0;
    }

    80%{
        transform:scale(1.1);
    }

    100%{
        transform:scale(1);
        opacity:1;
    }

}

h1{
    color:#14231b;
    font-size:30px;
    margin-bottom:10px;
}

.subtitle{
    color:#718078;
    line-height:1.6;
    font-size:15px;
}

.info{
    margin:25px 0;
    padding:18px;
    border-radius:15px;
    background:#f3f8f5;
    color:#526259;
    font-size:14px;
}

.info p{
    margin:8px 0;
}

.email{
    color:#20a75c;
    font-weight:bold;
}

button{
    width:100%;
    border:none;
    padding:15px;
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

.brand{
    margin-top:25px;
    font-size:12px;
    color:#9aa59f;
}

</style>

</head>

<body>

<div class="card">

    <div class="check">
        &#10003;
    </div>

    <h1>Booking Confirmed!</h1>

    <p class="subtitle">
        Your turf has been successfully reserved.
        Get ready to play! &#127942;
    </p>

    <div class="info">

        <p>&#128231; Confirmation email has been sent to your registered email.</p>

        <p>
            &#9200; You'll receive a payment reminder
            30 minutes before your booking time.
        </p>

    </div>

    <a href="booking.jsp"
       style="text-decoration:none;">

        <button>
            Explore More Venues &rarr;
        </button>

    </a>

    <div class="brand">
        TurfBook &bull; Book your game. Own the moment.
    </div>

</div>

</body>

</html>