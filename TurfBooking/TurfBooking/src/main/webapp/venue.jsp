<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>TurfBook | Manage Venue</title>

<style>

*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family:Arial, sans-serif;
    background:#f4f7f5;
    color:#17231d;
}

/* NAVBAR */

.navbar{
    height:72px;
    background:#102b1d;
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:0 7%;
    color:white;
}

.logo{
    font-size:25px;
    font-weight:800;
    color:#39dd82;
}

.logo span{
    color:white;
}

.owner{
    font-size:13px;
    color:#a9bcb1;
}

/* MAIN */

.container{
    width:88%;
    max-width:1100px;
    margin:45px auto;
}

.header{
    margin-bottom:30px;
}

.header h1{
    font-size:34px;
    margin-bottom:8px;
}

.header p{
    color:#748179;
}

/* GRID */

.dashboard{
    display:grid;
    grid-template-columns:1fr 1.5fr;
    gap:30px;
}

/* LEFT */

.info-card{
    background:#102b1d;
    color:white;
    border-radius:22px;
    padding:35px;
    min-height:450px;
    position:relative;
    overflow:hidden;
}

.info-card::after{
    content:"&#9917;";
    position:absolute;
    right:-20px;
    bottom:-30px;
    font-size:180px;
    opacity:.08;
}

.info-card h2{
    font-size:28px;
    margin-bottom:15px;
}

.info-card p{
    color:#b8c9bf;
    line-height:1.7;
    font-size:14px;
}

.steps{
    margin-top:35px;
}

.step{
    display:flex;
    gap:14px;
    margin-bottom:20px;
}

.number{
    min-width:34px;
    height:34px;
    border-radius:50%;
    background:#27bd6c;
    display:flex;
    align-items:center;
    justify-content:center;
    font-weight:bold;
}

.step span{
    color:#d2ddd7;
    font-size:14px;
    line-height:1.5;
}

/* FORM */

.form-card{
    background:white;
    padding:35px;
    border-radius:22px;
    box-shadow:0 15px 40px rgba(20,40,30,.08);
}

.form-card h2{
    margin-bottom:7px;
}

.form-card .subtitle{
    color:#7c8881;
    font-size:14px;
    margin-bottom:25px;
}

.form-group{
    margin-bottom:20px;
}

label{
    display:block;
    font-size:13px;
    font-weight:bold;
    margin-bottom:8px;
}

input,
textarea{
    width:100%;
    border:1px solid #dce5df;
    border-radius:11px;
    padding:14px;
    outline:none;
    font-size:14px;
    font-family:inherit;
}

textarea{
    resize:vertical;
}

input:focus,
textarea:focus{
    border-color:#27bd6c;
    box-shadow:0 0 0 4px rgba(39,189,108,.1);
}

.btn{
    width:100%;
    border:0;
    border-radius:11px;
    padding:15px;
    background:#102b1d;
    color:white;
    font-weight:bold;
    font-size:15px;
    cursor:pointer;
}

.btn:hover{
    background:#27bd6c;
}

/* SUCCESS */

.success{
    background:#e4f8ec;
    color:#167344;
    padding:13px;
    border-radius:10px;
    margin-bottom:20px;
    font-size:14px;
    text-align:center;
}

@media(max-width:800px){

    .dashboard{
        grid-template-columns:1fr;
    }

    .info-card{
        min-height:auto;
    }

    .container{
        width:92%;
    }

}

</style>

</head>

<body>


<nav class="navbar">

    <div class="logo">
        Turf<span>Book</span>
    </div>

    <div class="owner">
        &#127970; Venue Owner Portal
    </div>

</nav>


<main class="container">

    <div class="header">

        <h1>Manage Your Venue</h1>

        <p>
            Add your turf details and make your venue available for players.
        </p>

    </div>


    <div class="dashboard">


        <!-- INFO -->

        <div class="info-card">

            <h2>Grow Your Turf Business &#128640;</h2>

            <p>
                List your sports venue on TurfBook and allow players
                to discover and book your turf easily.
            </p>


            <div class="steps">

                <div class="step">

                    <div class="number">1</div>

                    <span>
                        Enter your venue name and location.
                    </span>

                </div>


                <div class="step">

                    <div class="number">2</div>

                    <span>
                        Add a clear description of your turf.
                    </span>

                </div>


                <div class="step">

                    <div class="number">3</div>

                    <span>
                        Save your venue and start receiving bookings.
                    </span>

                </div>

            </div>

        </div>


        <!-- FORM -->

        <div class="form-card">

            <h2>Venue Details</h2>

            <p class="subtitle">
                Provide accurate information about your turf.
            </p>


<%
String status = request.getParameter("status");

if("success".equals(status) ||
   "updated".equals(status)){
%>

            <div class="success">
                &#10003; Venue details updated successfully!
            </div>

<%
}
%>


            <form
                action="VenueServlet"
                method="post">


                <div class="form-group">

                    <label>Venue Name</label>

                    <input
                        type="text"
                        name="name"
                        placeholder="Example: Green Arena Turf"
                        required>

                </div>


                <div class="form-group">

                    <label>Location</label>

                    <input
                        type="text"
                        name="location"
                        placeholder="Example: Anna Nagar, Chennai"
                        required>

                </div>


                <div class="form-group">

                    <label>Price Per Hour (&#8377;)</label>

                    <input
                        type="number"
                        name="price_per_hour"
                        min="1"
                        step="0.01"
                        placeholder="Example: 700"
                        required>

                </div>


                <div class="form-group">

                    <label>Image Path (Optional)</label>

                    <input
                        type="text"
                        name="image_url"
                        placeholder="images/turf1.jpeg">

                </div>


                <div class="form-group">

                    <label>Description</label>

                    <textarea
                        name="description"
                        rows="6"
                        placeholder="Describe your turf, facilities, playing surface, etc."></textarea>

                </div>


                <button
                    type="submit"
                    class="btn">

                    Save Venue Details &rarr;

                </button>

            </form>

        </div>

    </div>

</main>

</body>

</html>