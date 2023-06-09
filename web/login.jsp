<%@ page import="dataNoBase.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%

%>

<%--session outdate--%>
<%

%>

<%--session update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv session msg--%>
<%
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
    // Default jump shop.jsp
    if (referenced == null) {
        referenced = "shop.jsp";
    }
%>

<%--recv parameters--%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String user_type = request.getParameter("user_type");
%>

<%--NullPointerException && NumberFormatException--%>
<%

%>

<%--parameters invalid--%>
<%

%>

<%--parameters react--%>
<%
    if (user_type != null) {
        // Administrator login.
        if (user_type.equals("admin")) {
            // Password correct.
            if (AdminDAO.isPasswordCorrect(username, password)) {
                session.setAttribute("person", AdminDAO.getAdminByUsername(username));
                session.setAttribute("login_status", true);
                session.setAttribute("referenced", "login.jsp");
                response.sendRedirect(referenced);
                return;
            }
        }
        // User login.
        else if (user_type.equals("customer")) {
            // Password correct.
            if (UserDAO.isPasswordCorrect(username, password)) {
                session.setAttribute("person", UserDAO.getUserByUsername(username));
                session.setAttribute("login_status", true);
                session.setAttribute("referenced", "login.jsp");
                response.sendRedirect(referenced);
                return;
            }
        }
    }
%>

<%--pre-action--%>
<%

%>

<%--页面事件--%>
<%--========================================================================================================================================--%>


<html>
<head>
    <link rel="stylesheet" href="css/login.css">
    <title>Login</title>
</head>
<body>


<div class="container">
    <h1>COMP2013J Databases and Info Sys</h1>
    <h2>Group3 Assignment</h2>
    <div class="login_box">
        <form action="login.jsp" method="post">
            <label class="username_box">Username:
                <input type="text" name="username" size="30" maxlength="20">
            </label><br>
            <label class="password_box">Password:
                <input type="password" name="password" size="30" maxlength="20">
            </label><br>

            <div class="radio_box">
                <div class="left_box">
                    <label><input type="radio" id="customer" name="user_type" value="customer">Customer</label>
                </div>
                <div class="right_box">
                    <label><input type="radio" id="admin" name="user_type" value="admin">Admin</label>
                </div>
            </div>
            <input type="submit" name="submit" value="Login">
        </form>
        <a href="create_account.jsp">Click to create an account</a>
    </div>
</div>
<%=username%>
<%=password%>

<%=AdminDAO.isPasswordCorrect(username, password)%>
</body>
</html>