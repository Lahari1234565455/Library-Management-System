<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Update Book | Library Management</title>
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
        box-shadow: 0 8px 30px rgba(0, 0, 0, 0.5);
    }

    h1 {
        text-align: center;
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
    }

    input[type="text"] {
        width: 100%;
        padding: 10px 12px;
        border-radius: 10px;
        border: none;
        background: rgba(255,255,255,0.1);
        color: #fff;
        margin-bottom: 10px;
    }

    input[type="submit"], input[type="reset"] {
        padding: 10px 25px;
        border-radius: 10px;
        border: none;
        cursor: pointer;
        font-weight: 500;
        background-color: #00bcd4;
        color: #0d1117;
        transition: all 0.3s;
        margin-top: 10px;
    }

    input[type="submit"]:hover, input[type="reset"]:hover {
        background-color: #0d1117;
        color: #00bcd4;
        border: 1px solid #00bcd4;
    }

    .message {
        text-align: center;
        font-size: 1.2rem;
        color: #f44336;
        margin-top: 20px;
    }

    a {
        display: block;
        margin: 20px auto 0 auto;
        padding: 10px 25px;
        border-radius: 10px;
        background-color: #00bcd4;
        color: #0d1117;
        text-decoration: none;
        font-weight: 500;
        text-align: center;
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
<h1>Update Book Details</h1>

<%
    String id = request.getParameter("id");
    int idNum = Integer.parseInt(id);

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "lms", "lms");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM books WHERE book_id = ?");
        ps.setInt(1, idNum);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>

<form action="<%=request.getContextPath()%>/book_update.jsp" method="post">
    <table>
        <tr>
            <td>Book ID:</td>
            <td><input type="text" name="id" value="<%=rs.getInt(1)%>" readonly /></td>
        </tr>
        <tr>
            <td>Title:</td>
            <td><input type="text" name="title" value="<%=rs.getString(2)%>" /></td>
        </tr>
        <tr>
            <td>Author:</td>
            <td><input type="text" name="author" value="<%=rs.getString(3)%>" /></td>
        </tr>
        <tr>
            <td>Quantity:</td>
            <td><input type="text" name="quantity" value="<%=rs.getInt(4)%>" /></td>
        </tr>
        <tr>
            <td><input type="submit" value="Update Book" /></td>
            <td><input type="reset" value="Clear" /></td>
        </tr>
    </table>
</form>

<%
        } else {
%>
<div class="message">No book found with ID <%= idNum %></div>
<%
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
%>
<div class="message">An error occurred. Please check server logs.</div>
<%
    }
%>

<a href="home.html">Go back to Home</a>
</div>
</body>
</html>
