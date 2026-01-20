<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String fullname = request.getParameter("fullname");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String mobile = request.getParameter("mobile");
    String email = request.getParameter("email");

    boolean success = false;
    String errorMsg = null;

    if (fullname != null && username != null && password != null && mobile != null && email != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/libraries", "app", "app");

            // Check if username already exists
            PreparedStatement checkStmt = conn.prepareStatement("SELECT Username FROM register WHERE Username = ?");
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                errorMsg = "Username already exists. Please choose another.";
            } else {
                PreparedStatement pst = conn.prepareStatement("INSERT INTO register (FullName, Username, Password, Mobile, Email) VALUES (?, ?, ?, ?, ?)");
                pst.setString(1, fullname);
                pst.setString(2, username);
                pst.setString(3, password);
                pst.setString(4, mobile);
                pst.setString(5, email);
                pst.executeUpdate();
                success = true;
                pst.close();
            }
            rs.close();
            checkStmt.close();
            conn.close();
        } catch (Exception e) {
            errorMsg = e.getMessage();
        }
    } else {
        errorMsg = "Please fill all fields.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title><%= success ? "Registration Success" : "Registration Error" %></title>
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
        .error {
            color: #ff6666;
        }
    </style>
</head>
<body>
    <div class="message-box">
        <% if(success) { %>
            <h1>Registration Successful!</h1>
            <p>Welcome, <%= fullname %>!</p>
            <form action="login.html">
                <button type="submit" class="ok-button">Go to Login</button>
            </form>
        <% } else { %>
            <h1 class="error">Registration Failed</h1>
            <p class="error"><%= errorMsg != null ? errorMsg : "Unknown error occurred." %></p>
            <form action="register.html">
                <button type="submit" class="ok-button">Try Again</button>
            </form>
        <% } %>
    </div>
</body>
</html>
