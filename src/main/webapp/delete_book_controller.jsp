<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Delete Book Result | Library Management</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<style>
    body {
        background-color: #0d1117;
        color: #fff;
        font-family: 'Roboto', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }
    .result-card {
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.5);
        text-align: center;
        max-width: 500px;
        width: 90%;
    }
    .result-card h2 {
        color: #00bcd4;
        margin-bottom: 20px;
        text-shadow: 1px 1px 5px #111;
    }
    .result-card p {
        font-size: 1.2rem;
        margin-bottom: 30px;
        color: #fff;
    }
    .success {
        color: #4CAF50;
        font-weight: 500;
    }
    .failure {
        color: #f44336;
        font-weight: 500;
    }
    .result-card a {
        display: inline-block;
        padding: 10px 25px;
        border-radius: 10px;
        background-color: #00bcd4;
        color: #0d1117;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
    }
    .result-card a:hover {
        background-color: #0d1117;
        color: #00bcd4;
        border: 1px solid #00bcd4;
    }
</style>
</head>
<body>
<%
    String message = "";
    String messageClass = "";
    try {
        String id = request.getParameter("id");
        int id_num = Integer.parseInt(id);

        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","lms","lms");
        PreparedStatement ps = con.prepareStatement("delete from books where book_id = ?");
        ps.setInt(1, id_num);
        int i = ps.executeUpdate();
        if(i>0){
            message = "Book deleted successfully!";
            messageClass = "success";
        } else {
            message = "Book deletion failed!";
            messageClass = "failure";
        }
        ps.close();
        con.close();
    } catch(Exception e){
        message = "Error: " + e.getMessage();
        messageClass = "failure";
    }
%>

<div class="result-card">
    <h2>Library Management System</h2>
    <p class="<%= messageClass %>"><%= message %></p>
    <a href="home.html">Go back to Home</a>
</div>

</body>
</html>
