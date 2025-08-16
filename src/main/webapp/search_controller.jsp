<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Book Details | Library Management</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<style>
    body {
        background-color: #0d1117;
        color: #fff;
        font-family: 'Roboto', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }

    .container {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 40px;
        max-width: 500px;
        width: 100%;
        text-align: center;
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
    }

    h1 {
        color: #00bcd4;
        margin-bottom: 20px;
        text-shadow: 1px 1px 5px #111;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    td {
        padding: 12px;
        text-align: left;
    }

    input[type="text"] {
        width: 100%;
        padding: 10px 12px;
        border-radius: 10px;
        border: none;
        background: rgba(255,255,255,0.1);
        color: #fff;
    }

    .message {
        font-size: 1.2rem;
        margin-top: 20px;
        color: #f44336; /* red for errors */
        font-weight: 500;
    }

    a {
        display: inline-block;
        margin-top: 25px;
        padding: 10px 25px;
        border-radius: 10px;
        background-color: #00bcd4;
        color: #0d1117;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
    }

    a:hover {
        background-color: #0d1117;
        color: #00bcd4;
        border: 1px solid #00bcd4;
    }
</style>
</head>
<body>
<div class="container">
    <h1>Book Details</h1>

<%
    String id = request.getParameter("id");
    int idNum = Integer.parseInt(id);

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "lms", "lms");
        PreparedStatement ps = con.prepareStatement("select * from books where book_id = ?");
        ps.setInt(1, idNum);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>

    <table>
        <tr>
            <td>Book ID:</td>
            <td><input type="text" value="<%=rs.getInt(1)%>" readonly /></td>
        </tr>
        <tr>
            <td>Title:</td>
            <td><input type="text" value="<%=rs.getString(2)%>" readonly /></td>
        </tr>
        <tr>
            <td>Author:</td>
            <td><input type="text" value="<%=rs.getString(3)%>" readonly /></td>
        </tr>
        <tr>
            <td>Quantity:</td>
            <td><input type="text" value="<%=rs.getInt(4)%>" readonly /></td>
        </tr>
    </table>

<%
        } else {
%>
    <div class="message">No book found with ID <%= id %></div>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch(Exception e) {
%>
    <div class="message">Error: <%= e.getMessage() %></div>
<%
    }
%>

    <a href="home.html">Go back to Home</a>
</div>
</body>
</html>
