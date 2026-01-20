<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("adminUsername");
    String password = request.getParameter("adminPassword");

    // Hardcoded admin credentials (you can replace with DB check)
    String adminUser = "ananya@30";
    String adminPass = "anu@30";

    if (username != null && password != null) {
        if(username.equals(adminUser) && password.equals(adminPass)) {
            session.setAttribute("adminLoggedIn", "true");
            response.sendRedirect("adminOrders.jsp");
        } else {
            out.println("<script>alert('Incorrect username or password');window.history.back();</script>");
        }
    } else {
        response.sendRedirect("admin.html");
    }
%>
