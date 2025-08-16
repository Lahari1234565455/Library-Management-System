<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>All Books | Library Management</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
<style>
    body {
        background-color: #0d1117;
        color: #fff;
        font-family: 'Roboto', sans-serif;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 1000px;
        margin: 40px auto;
        padding: 30px;
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.5);
    }

    h1 {
        text-align: center;
        color: #00bcd4;
        margin-bottom: 10px;
        text-shadow: 1px 1px 5px #111;
    }

    h3 {
        text-align: center;
        margin-bottom: 30px;
        text-decoration: underline;
        color: #fff;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        background: rgba(255,255,255,0.05);
    }

    th, td {
        padding: 15px;
        text-align: center;
    }

    th {
        background-color: #00bcd4;
        color: #0d1117;
    }

    tr:nth-child(even) {
        background: rgba(255,255,255,0.02);
    }

    tr:hover {
        background: rgba(0,188,212,0.2);
    }

    a {
        display: inline-block;
        margin: 20px auto 0 auto;
        padding: 10px 25px;
        border-radius: 10px;
        background-color: #00bcd4;
        color: #0d1117;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.3s;
        text-align: center;
    }

    a:hover {
        background-color: #0d1117;
        color: #00bcd4;
        border: 1px solid #00bcd4;
    }

    @media (max-width: 768px) {
        table, th, td {
            font-size: 14px;
            padding: 10px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <h1>Library Management System</h1>
        <h3>All Books</h3>

        <%
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "lms", "lms");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM books");
            ResultSet rs = ps.executeQuery();
        %>

        <table>
            <tr>
                <th>Book ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Quantity</th>
            </tr>

            <%
            while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getInt(4) %></td>
            </tr>
            <%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("<p style='color:red; text-align:center; margin-top:20px;'>Error: " + e.getMessage() + "</p>");
        }
        %>
        </table>

        <a href="home.html">Go back to Home</a>
    </div>
</body>
</html>
