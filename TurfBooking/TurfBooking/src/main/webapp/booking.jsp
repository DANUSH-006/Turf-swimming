<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.Turf.DBConnection" %>

<%
String nameFilter = request.getParameter("name");
String locationFilter = request.getParameter("location");

if (nameFilter == null) nameFilter = "";
if (locationFilter == null) locationFilter = "";
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>TurfBook | Available Venues</title>

<style>

/* =========================
   ROOT VARIABLES
========================= */

:root {
    --ink: #102a2a;
    --ink-soft: #385454;
    --green: #1d9b64;
    --green-dark: #147a4d;
    --lime: #d8f36a;
    --paper: #fffdf7;
    --canvas: #f4f5ed;
    --line: #dce5da;
    --muted: #71827d;
}

/* =========================
   RESET
========================= */

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    width: 100%;
    scroll-behavior: smooth;
}

body {
    width: 100%;
    min-height: 100vh;
    color: var(--ink);
    background: var(--canvas);
    font-family: "Segoe UI", Tahoma, Arial, sans-serif;
    overflow-x: hidden;
}

/* =========================
   NAVBAR
========================= */

.navbar {
    width: 100%;
    min-height: 76px;
    padding: 0 clamp(20px, 7vw, 100px);

    display: flex;
    align-items: center;
    justify-content: space-between;

    position: sticky;
    top: 0;
    z-index: 100;

    color: #fff;
    background: var(--ink);

    border-bottom: 1px solid rgba(216, 243, 106, 0.14);
}

.logo {
    color: var(--lime);
    font-size: clamp(21px, 2.5vw, 26px);
    font-weight: 850;
    letter-spacing: -0.04em;
    white-space: nowrap;
}

.logo span {
    color: #fff;
}

.nav-title {
    color: #b7c9bd;
    font-size: clamp(10px, 1.2vw, 12px);
    font-weight: 700;
    letter-spacing: 0.16em;
    text-transform: uppercase;
}

/* =========================
   HERO
========================= */

.hero {
    width: 100%;
    position: relative;
    overflow: hidden;

    padding: clamp(55px, 8vw, 85px) 5%
             clamp(85px, 10vw, 110px);

    color: #fff;

    background:
        radial-gradient(
            circle at 88% 18%,
            rgba(216, 243, 106, 0.24) 0 4%,
            transparent 25%
        ),
        linear-gradient(
            132deg,
            #102a2a 0%,
            #175b45 64%,
            #1d9b64 100%
        );
}

.hero::after {
    content: "";

    width: min(360px, 70vw);
    height: min(360px, 70vw);

    position: absolute;
    right: -150px;
    bottom: -255px;

    border: 1px solid rgba(216, 243, 106, 0.4);
    border-radius: 50%;

    box-shadow:
        0 0 0 25px rgba(216, 243, 106, 0.06),
        0 0 0 55px rgba(216, 243, 106, 0.04);
}

.hero-content {
    width: 100%;
    max-width: 950px;

    margin: auto;

    position: relative;
    z-index: 1;

    text-align: center;
}

.hero h1 {
    margin-bottom: 15px;

    font-family: Georgia, "Times New Roman", serif;

    font-size: clamp(2.1rem, 5vw, 4rem);
    line-height: 1.1;

    font-weight: 700;
    letter-spacing: -0.04em;
}

.hero p {
    width: 100%;
    max-width: 650px;

    margin: 0 auto 35px;

    color: #d8e9df;

    font-size: clamp(14px, 1.8vw, 16px);
    line-height: 1.7;
}

/* =========================
   SEARCH
========================= */

.search-box {
    width: 100%;

    display: flex;
    gap: 10px;

    padding: 11px;

    background: var(--paper);

    border: 1px solid rgba(255, 255, 255, 0.4);
    border-radius: 16px;

    box-shadow: 0 18px 45px rgba(5, 28, 25, 0.3);
}

.search-box input {
    flex: 1;
    min-width: 0;

    padding: 15px;

    color: var(--ink);
    background: #f0f5ee;

    border: 1px solid transparent;
    border-radius: 10px;

    outline: none;

    font-size: 14px;
}

.search-box input:focus {
    border-color: var(--green);

    box-shadow:
        0 0 0 3px rgba(29, 155, 100, 0.12);
}

.search-btn,
.book-btn {
    cursor: pointer;

    color: var(--ink);
    background: var(--lime);

    border: 0;
    border-radius: 10px;

    font-weight: 800;

    transition:
        transform 0.2s ease,
        box-shadow 0.2s ease,
        background 0.2s ease;
}

.search-btn {
    min-width: 120px;

    padding: 0 25px;

    font-size: 14px;
}

.search-btn:hover,
.book-btn:hover {
    background: #e6ff88;

    transform: translateY(-2px);

    box-shadow:
        0 8px 18px rgba(216, 243, 106, 0.24);
}

/* =========================
   MAIN CONTAINER
========================= */

.container {
    width: 90%;
    max-width: 1250px;

    margin: 45px auto 65px;

    position: relative;
    z-index: 2;
}

.booking-alert {
    margin-bottom: 20px;
    padding: 13px 16px;
    color: #8a3d00;
    background: #fff4df;
    border: 1px solid #f0d29b;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 600;
}

/* =========================
   SECTION HEADER
========================= */

.section-header {
    display: flex;

    align-items: flex-end;
    justify-content: space-between;

    margin-bottom: 25px;
}

.section-header h2 {
    margin-bottom: 6px;

    font-family: Georgia, "Times New Roman", serif;

    font-size: clamp(25px, 3vw, 30px);
    line-height: 1.2;

    letter-spacing: -0.03em;
}

.section-header p,
.empty p {
    color: var(--muted);

    font-size: 14px;
    line-height: 1.6;
}

/* =========================
   VENUE GRID
========================= */

.venue-grid {
    width: 100%;

    display: grid;

    grid-template-columns:
        repeat(auto-fit, minmax(min(100%, 320px), 1fr));

    gap: 24px;
}

/* =========================
   VENUE CARD
========================= */

.venue-card {
    width: 100%;
    overflow: hidden;

    background: var(--paper);

    border: 1px solid rgba(16, 42, 42, 0.08);
    border-radius: 18px;

    box-shadow:
        0 12px 28px rgba(22, 47, 38, 0.08);

    transition:
        transform 0.25s ease,
        box-shadow 0.25s ease;
}

.venue-card:hover {
    transform: translateY(-7px);

    box-shadow:
        0 22px 40px rgba(22, 47, 38, 0.15);
}

/* =========================
   IMAGE
========================= */

.image-wrapper {
    width: 100%;

    height: clamp(190px, 22vw, 230px);

    position: relative;
    overflow: hidden;

    background: #dce7db;
}

.image-wrapper::after {
    content: "";

    position: absolute;
    inset: 0;

    pointer-events: none;

    background:
        linear-gradient(
            180deg,
            transparent 60%,
            rgba(10, 35, 30, 0.26)
        );
}

.image-wrapper img {
    width: 100%;
    height: 100%;

    display: block;

    object-fit: cover;

    transition: transform 0.5s ease;
}

.venue-card:hover .image-wrapper img {
    transform: scale(1.06);
}

/* =========================
   AVAILABLE
========================= */

.available {
    position: absolute;

    top: 15px;
    right: 15px;

    z-index: 1;

    padding: 7px 11px;

    color: var(--ink);
    background: var(--lime);

    border-radius: 20px;

    font-size: 11px;
    font-weight: 800;

    white-space: nowrap;
}

/* =========================
   VENUE BODY
========================= */

.venue-body {
    padding: clamp(18px, 3vw, 23px);
}

.venue-title {
    margin-bottom: 8px;

    color: var(--ink);

    font-family: Georgia, "Times New Roman", serif;

    font-size: clamp(19px, 2vw, 22px);
    line-height: 1.3;
}

.description {
    min-height: 45px;

    margin-bottom: 13px;

    color: var(--muted);

    font-size: 14px;
    line-height: 1.6;

    overflow-wrap: anywhere;
}

.location {
    margin-bottom: 20px;

    color: var(--ink-soft);

    font-size: 13px;
    font-weight: 600;

    line-height: 1.5;

    overflow-wrap: anywhere;
}

.location-icon {
    color: var(--green);
    font-weight: 800;
}

/* =========================
   PRICE
========================= */

.price-box {
    display: flex;

    align-items: baseline;
    flex-wrap: wrap;

    gap: 5px;

    margin-bottom: 14px;

    padding: 10px 12px;

    background: #f0f8e8;

    border-left: 4px solid var(--green);

    border-radius: 8px;
}

.price-amount {
    color: var(--green-dark);

    font-family: "Segoe UI", Arial, sans-serif;

    font-size: clamp(19px, 2vw, 22px);
    font-weight: 800;
}

.price-unit {
    color: var(--muted);

    font-family: "Segoe UI", Arial, sans-serif;

    font-size: 13px;
    font-weight: 600;
}

/* =========================
   BOOKING FORM
========================= */

.booking-form {
    padding-top: 18px;

    border-top: 1px solid var(--line);
}

.form-label {
    display: block;

    margin-bottom: 7px;

    color: var(--ink-soft);

    font-size: 12px;
    font-weight: 800;

    letter-spacing: 0.03em;

    text-transform: uppercase;
}

.form-input {
    width: 100%;

    margin-bottom: 14px;

    padding: 12px;

    color: var(--ink);
    background: #f6f8f2;

    border: 1px solid var(--line);
    border-radius: 9px;

    outline: none;

    font-family: inherit;
    font-size: 14px;
}

.form-input:focus {
    border-color: var(--green);

    box-shadow:
        0 0 0 3px rgba(29, 155, 100, 0.12);
}

.book-btn {
    width: 100%;

    min-height: 46px;

    padding: 13px;

    font-size: 14px;
}

/* =========================
   EMPTY
========================= */

.empty {
    grid-column: 1 / -1;

    padding: clamp(45px, 8vw, 70px) 20px;

    text-align: center;

    background: var(--paper);

    border: 1px solid rgba(16, 42, 42, 0.08);

    border-radius: 18px;

    box-shadow:
        0 12px 28px rgba(22, 47, 38, 0.06);
}

.empty-icon {
    margin-bottom: 15px;

    color: var(--green);

    font-size: 45px;
}

.empty h3 {
    margin-bottom: 8px;

    font-family: Georgia, "Times New Roman", serif;

    font-size: 22px;
}

/* =========================
   FOOTER
========================= */

footer {
    width: 100%;

    padding: 25px 15px;

    color: #82918a;

    font-size: 12px;

    text-align: center;

    letter-spacing: 0.04em;

    line-height: 1.6;
}

/* =========================
   TABLET
========================= */

@media (max-width: 900px) {

    .navbar {
        min-height: 70px;
    }

    .hero {
        padding-top: 60px;
        padding-bottom: 95px;
    }

    .container {
        width: 92%;
    }

    .venue-grid {
        grid-template-columns:
            repeat(2, minmax(0, 1fr));

        gap: 20px;
    }

    .image-wrapper {
        height: 210px;
    }
}

/* =========================
   MOBILE
========================= */

@media (max-width: 650px) {

    .navbar {
        min-height: 64px;
        padding: 0 5%;
    }

    .logo {
        font-size: 22px;
    }

    .nav-title {
        display: none;
    }

    .hero {
        padding: 50px 5% 85px;
    }

    .hero h1 {
        font-size: clamp(2rem, 10vw, 2.7rem);
    }

    .hero p {
        margin-bottom: 28px;

        font-size: 14px;
    }

    .search-box {
        flex-direction: column;
        gap: 9px;

        padding: 10px;
    }

    .search-box input {
        width: 100%;

        min-height: 48px;
    }

    .search-btn {
        width: 100%;

        min-height: 48px;
    }

    .container {
        width: 90%;

        margin-top: -40px;
    }

    .section-header {
        display: block;

        margin-bottom: 20px;
    }

    .section-header p {
        margin-top: 5px;
    }

    .venue-grid {
        grid-template-columns: 1fr;

        gap: 20px;
    }

    .image-wrapper {
        height: 220px;
    }

    .venue-body {
        padding: 20px;
    }
}

/* =========================
   SMALL MOBILE
========================= */

@media (max-width: 400px) {

    .hero {
        padding-top: 42px;
        padding-bottom: 75px;
    }

    .hero h1 {
        font-size: 2rem;
    }

    .hero p {
        font-size: 13px;
    }

    .container {
        width: 92%;
    }

    .image-wrapper {
        height: 195px;
    }

    .venue-body {
        padding: 17px;
    }

    .available {
        top: 10px;
        right: 10px;

        padding: 6px 9px;

        font-size: 10px;
    }

    .price-box {
        padding: 9px 10px;
    }

    footer {
        font-size: 11px;
    }
}

/* =========================
   LARGE DESKTOP
========================= */

@media (min-width: 1400px) {

    .venue-grid {
        grid-template-columns:
            repeat(3, minmax(0, 1fr));
    }

    .container {
        max-width: 1300px;
    }
}

/* =========================
   TOUCH DEVICES
========================= */

@media (hover: none) {

    .venue-card:hover {
        transform: none;

        box-shadow:
            0 12px 28px rgba(22, 47, 38, 0.08);
    }

    .venue-card:hover .image-wrapper img {
        transform: none;
    }

    .search-btn:hover,
    .book-btn:hover {
        transform: none;
        box-shadow: none;
    }
}

/* =========================
   ACCESSIBILITY
========================= */

button,
input {
    font-family: inherit;
}

button:focus-visible,
input:focus-visible {
    outline: 3px solid rgba(29, 155, 100, 0.3);
    outline-offset: 2px;
}

</style>

</head>

<body>

<nav class="navbar">
    <div class="logo">
        Turf<span>Book</span>
    </div>

    <div class="nav-title">
        Find &bull; Book &bull; Play
    </div>
</nav>

<section class="hero">

    <div class="hero-content">

        <h1>Find Your Perfect Turf</h1>

        <p>
            Discover the best sports venues near you and book your slot
            in just a few clicks.
        </p>

        <form method="get" class="search-box">

            <input
                type="text"
                name="name"
                placeholder="Search venue name..."
                value="<%= nameFilter %>"
            >

            <input
                type="text"
                name="location"
                placeholder="Search location..."
                value="<%= locationFilter %>"
            >

            <button type="submit" class="search-btn">
                Search
            </button>

        </form>

    </div>

</section>

<main class="container">

    <%
        String bookingError = request.getParameter("error");
        String bookingMessage = null;
        if ("missing".equals(bookingError)) bookingMessage = "Please select a date and time.";
        else if ("past".equals(bookingError)) bookingMessage = "Please choose a future date and time.";
        else if ("booked".equals(bookingError)) bookingMessage = "That slot is already booked. Please choose another time.";
        else if ("invalid".equals(bookingError)) bookingMessage = "Invalid booking details. Please try again.";
    %>

    <% if (bookingMessage != null) { %>
        <div class="booking-alert"><%= bookingMessage %></div>
    <% } %>

    <div class="section-header">

        <div>

            <h2>Available Venues</h2>

            <p>
                Choose a venue and reserve your preferred time.
            </p>

        </div>

    </div>

    <div class="venue-grid">

<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.createConnection();

    String sql = "SELECT * FROM venues WHERE 1=1";

    if (!nameFilter.isEmpty()) {
        sql += " AND name LIKE ?";
    }

    if (!locationFilter.isEmpty()) {
        sql += " AND location LIKE ?";
    }

    ps = con.prepareStatement(sql);

    int idx = 1;

    if (!nameFilter.isEmpty()) {
        ps.setString(idx++, "%" + nameFilter + "%");
    }

    if (!locationFilter.isEmpty()) {
        ps.setString(idx++, "%" + locationFilter + "%");
    }

    rs = ps.executeQuery();

    boolean hasVenues = false;

    while (rs.next()) {

        hasVenues = true;

        String imageUrl = rs.getString("image_url");

        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            imageUrl = "images/turf1.jpeg";
        }

%>

        <div class="venue-card">

            <div class="image-wrapper">

                <img
                    src="<%= imageUrl %>"
                    alt="<%= rs.getString("name") %>"
                >

                <div class="available">
                    &#9679; Available
                </div>

            </div>

            <div class="venue-body">

                <h3 class="venue-title">
                    <%= rs.getString("name") %>
                </h3>

                <p class="description">
                    <%= rs.getString("description") %>
                </p>

                <p class="location">

                    <span class="location-icon">
                        &#128205;
                    </span>

                    <%= rs.getString("location") %>

                </p>

                <div class="price-box">

                    <span class="price-amount">

                        &#8377;<%= String.format(
                            "%.0f",
                            rs.getDouble("price_per_hour")
                        ) %>

                    </span>

                    <span class="price-unit">
                        / hour
                    </span>

                </div>

                <form
                    action="BookingServlet"
                    method="post"
                    class="booking-form"
                >

                    <input
                        type="hidden"
                        name="venue_id"
                        value="<%= rs.getInt("id") %>"
                    >

                    <label class="form-label">
                        Select Date
                    </label>

                    <input
                        type="date"
                        name="booking_date"
                        class="form-input booking-date"
                        required
                    >

                    <label class="form-label">
                        Select Time
                    </label>

                    <input
                        type="time"
                        name="booking_time"
                        class="form-input"
                        required
                    >

                    <button
                        type="submit"
                        class="book-btn"
                    >
                        Book Now &rarr;
                    </button>

                </form>

            </div>

        </div>

<%

    }

    if (!hasVenues) {

%>

        <div class="empty">

            <div class="empty-icon">
                &#127970;
            </div>

            <h3>
                No Venues Found
            </h3>

            <p>
                Try searching with another venue name or location.
            </p>

        </div>

<%

    }

} catch (Exception e) {

    out.println(
        "<div class='empty'>" +
        "<h3>Something went wrong</h3>" +
        "<p>Please try again later.</p>" +
        "</div>"
    );

} finally {

    try {
        if (rs != null) rs.close();
    } catch (Exception e) {}

    try {
        if (ps != null) ps.close();
    } catch (Exception e) {}

    try {
        if (con != null) con.close();
    } catch (Exception e) {}

}

%>

    </div>

</main>

<footer>
    &copy; 2026 TurfBook &bull; Book your game, enjoy your play.
</footer>

<script>

const today = new Date();

const todayDate =
    today.getFullYear() +
    "-" +
    String(today.getMonth() + 1).padStart(2, "0") +
    "-" +
    String(today.getDate()).padStart(2, "0");

document
    .querySelectorAll(".booking-date")
    .forEach(function(input) {

        input.min = todayDate;

    });

</script>

</body>

</html>

