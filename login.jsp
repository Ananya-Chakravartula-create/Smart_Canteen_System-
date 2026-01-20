<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String fullname = null;
    boolean loginSuccess = false;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        Connection conn = DriverManager.getConnection(
            "jdbc:derby://localhost:1527/libraries", "app", "app"
        );  

        
        PreparedStatement pst = conn.prepareStatement(
            "SELECT FULLNAME FROM REGISTER WHERE USERNAME=? AND PASSWORD=?"
        );

        pst.setString(1, username);
        pst.setString(2, password);

        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            loginSuccess = true;

            
            fullname = rs.getString("FULLNAME");

            // Session values
            session.setAttribute("fullname", fullname);
            session.setAttribute("username", username);
        }

        rs.close();
        pst.close();
        conn.close();

    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    }
%>

<% if (loginSuccess) { %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Success</title>
    <style>
        body {
            background: url('Food.jpg') no-repeat center center fixed;
            background-size: cover;
            text-align: center;
            padding-top: 100px;
            color: white;
            font-family: Arial, sans-serif;
        }
        .message-box {
            background: rgba(0, 0, 0, 0.6);
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
        }
        .ok-button {
            margin-top: 20px;
            padding: 10px 20px;
            background: #4CAF50;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .ok-button:hover {
            background: #45a049;
        }
    </style>
</head>

<body>
    <div class="message-box">
        <h1>Login Successful!</h1>
        <p>Welcome, <%= fullname %>!</p>
        <form action="menu.html">
            <button type="submit" class="ok-button">OK</button>
        </form>
    </div>
</body>
</html>
<% } else {
    response.sendRedirect("login.html");
} %>


