<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Orders</title>
    <style>
        body {
            background: url('Food.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
        }
        table {
            margin: 10px auto;
            border-collapse: collapse;
            width: 60%;
        }
        th, td {
            border: 1px solid white;
            padding: 10px;
        }
        th {
            background-color: rgb(202, 145, 79);
        }
    </style>
</head>
<body>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <h1>All Orders</h1>
    <table>
        <tr>
            <th>Full Name</th>
            <th>Username</th>
            <th>Item</th>
            <th>Price</th>
            <th>Date</th>
        </tr>
        <%
            try {
                Class.forName("org.apache.derby.jdbc.ClientDriver");
                Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/libraries", "app", "app");

                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM orders");

                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("fullname") + "</td>");
                    out.println("<td>" + rs.getString("username") + "</td>");
                    out.println("<td>" + rs.getString("item") + "</td>");
                    out.println("<td>" + rs.getDouble("price") + "</td>");
                    out.println("<td>" + rs.getDate("order_date") + "</td>");
                    out.println("</tr>");
                }
                conn.close();
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            }
        %>
    </table>
</body>
</html>
