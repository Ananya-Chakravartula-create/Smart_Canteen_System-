<%@ page import="java.sql.*,java.util.*,java.text.*,org.json.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get orderDetails JSON string and total from form POST
    String orderDetails = request.getParameter("orderDetails");
    String totalStr = request.getParameter("total");

    // Assume fullname and username stored in session on login
    String fullname = (String) session.getAttribute("fullname");
    String username = (String) session.getAttribute("username");

    if (fullname == null || username == null) {
        out.println("<script>alert('User not logged in. Please login first.'); window.location.href='login.html';</script>");
        return;
    }

    if (orderDetails == null || orderDetails.trim().isEmpty()) {
        out.println("<script>alert('No items in order!'); window.location.href='menu.html';</script>");
        return;
    }

    java.sql.Date sqlDate = new java.sql.Date(System.currentTimeMillis());

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        conn = DriverManager.getConnection("jdbc:derby://localhost:1527/libraries", "app", "app");

        // Insert each item separately
        String sql = "INSERT INTO orders (item, price, fullname, username, order_date) VALUES (?, ?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);

        // Parse JSON array of items
        JSONArray arr = new JSONArray(orderDetails);

        for (int i = 0; i < arr.length(); i++) {
            JSONObject obj = arr.getJSONObject(i);
            String item = obj.getString("item");
            int price = obj.getInt("price");

            ps.setString(1, item);
            ps.setInt(2, price);
            ps.setString(3, fullname);
            ps.setString(4, username);
            ps.setDate(5, sqlDate);
            ps.executeUpdate();
        }

        // Optionally clear session or keep logged in
        // session.invalidate();

        out.println("<script>alert('Order placed successfully! Redirecting to homepage...'); window.location.href='index.html';</script>");
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
