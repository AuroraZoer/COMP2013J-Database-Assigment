<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dataNoBase.Person" %>
<%@ page import="dataNoBase.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%--no session--%>
<%
    if (session.isNew()) {
        session.setAttribute("referenced", "shopping_car.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval() < 0) {
        session.setAttribute("referenced", "shopping_car.jsp");
        response.sendRedirect("login.jsp");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>


<%--recv session msg--%>
<%
    Person user = (Person) session.getAttribute("person");
    Boolean login_status = (Boolean) session.getAttribute("login_status");
    String referenced = (String) session.getAttribute("referenced");
%>

<%--session invalid--%>
<%
    if (user == null) {
        session.setAttribute("referenced", "shopping_car.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
    if (user.getType() != 1) {
        session.setAttribute("referenced", "shopping_car.jsp");
        response.sendRedirect(referenced);
    }
    if (login_status == null || !login_status) {
        session.setAttribute("referenced", "shopping_car.jsp");
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%--recv parameters--%>
<%
    Person person = (Person) session.getAttribute("person");
    String page_str = request.getParameter("page_num");
    String keyword_str = request.getParameter("keyword");
    String delete_tid_str = request.getParameter("delete_tid");
    String modify_tid_str = request.getParameter("modify_tid");
    String modify_str = request.getParameter("modify_num");
    String paid_tid_str = request.getParameter("paid_tid");
%>

<%--NullPointerException && NumberFormatException--%>
<%
    int page_num = 1;
    try {
        page_num = Integer.parseInt(page_str);
    } catch (Exception ignored) {
    }
    int delete_tid = -1;
    try {
        delete_tid = Integer.parseInt(delete_tid_str);
    } catch (Exception ignored) {
    }
    int modify_tid = -1;
    try {
        modify_tid = Integer.parseInt(modify_tid_str);
    } catch (Exception ignored) {
    }
    int modify_num = -1;
    try {
        modify_num = Integer.parseInt(modify_str);
    } catch (Exception ignored) {
    }
    int keyword = -1;
    try {
        keyword = Integer.parseInt(keyword_str);
    } catch (Exception ignored) {
    }
    int paid_tid = -1;
    try {
        paid_tid = Integer.parseInt(paid_tid_str);
    } catch (Exception ignored) {
    }
%>

<%--parameters react--%>
<%
    if (delete_tid != -1) {
        TransactionDAO.deleteTransaction(delete_tid);
    }
    if (modify_tid != -1 && modify_num > 0) {
        TransactionDAO.updateTransactionQuantity(modify_tid, modify_num);
    }
    if (paid_tid != -1) {
        TransactionDAO.updateTransactionPaymentStatus(paid_tid);
    }
%>

<%--pre-action--%>
<%
    List<Transaction> transactions;

    if (keyword == -1) {
        transactions = TransactionDAO.getUserTransactions(user.getId(), page_num);
    } else {
        transactions = new ArrayList<Transaction>();
        transactions.add(TransactionDAO.getTransactionById(keyword));
    }
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>


<html>
<head>
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="css/shopping_car.css">

</head>
<body>

<div class="whole">
    <div class="mid_box">
        <div class="intro_text">Welcome <%=person.getName()%>, this is your shopping cart !</div>
        <div class="main_box">
            <% for (Transaction transaction : transactions) {
                Commodity commodity = CommodityDAO.getCommodityByCid(transaction.getCid());
                if (commodity == null) {
                    continue;
                }
            %>
            <div class="item_box">
                <div class="item_left_box">
                    <%=commodity.getCategory()%> <br>
                </div>
                <div class="item_mid_box">
                    <div class="item_top_box">
                        <%=commodity.getItemName()%> <br>
                    </div>
                    <div class="item_bottom_box">
                        <span><%=transaction.isPaid() ? "is paid" : "not paid"%></span>
                        <form action="shopping_car.jsp" method="post">
                            <input type="hidden" name="page_num" value="<%=page_num%>">
                            <%if (keyword_str != null) {%>
                            <input type="hidden" name="keyword" value="<%=keyword%>">
                            <%}%>
                            <input type="hidden" name="paid_tid" value="<%=transaction.getTid()%>">
                            <input type="submit" value="pay">
                        </form>
                    </div>
                </div>
                <div class="item_right_box">
                    <span class="price">
                        ¥ <%=commodity.getPrice()%> <br>
                    </span>
                    <form class="stock" action="shopping_car.jsp" method="post">
                        <input type="number" name="add_transaction_number" min="1" max="<%=commodity.getStock()%>"
                               step="1" placeholder="<%=transaction.getQuantity()%>">
                        <input type="hidden" name="page_num" value="<%=page_num%>">
                        <%if (keyword_str != null) {%>
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <%}%>
                        <input type="hidden" name="add_transaction_cid" value="<%=transaction.getTid()%>">
                        <input type="submit" value="modify">
                    </form>
                    <form action="shopping_car.jsp" method="post">
                        <input type="hidden" name="page_num" value="<%=page_num%>">
                        <%if (keyword_str != null) {%>
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <%}%>
                        <input type="hidden" name="delete_tid" value="<%=transaction.getTid()%>">
                        <input type="submit" value="delete">
                    </form>
                </div>
            </div>
            <% } %>

            <div class="pagination_box">
                <div class="last_page">
                    <form action="shopping_car.jsp" method="post">
                        <input type="hidden" name="page_num" value="<%=page_num<=1?1:page_num-1 %>">
                        <%if (keyword_str != null) {%>
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <%}%>
                        <input type="submit" value="last page">

                    </form>
                </div>

                <div class="next_page">
                    <form action="shopping_car.jsp" method="post">
                        <input type="hidden" name="page_num" value="<%=transactions.size()<10?page_num:page_num+1 %>">
                        <%if (keyword_str != null) {%>
                        <input type="hidden" name="keyword" value="<%=keyword%>">
                        <%}%>
                        <input type="submit" value="next page">
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="right_box">
        <%--User interface--%>
        <div class="user">
            <a href="userMain.jsp">
                <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
            </a>
        </div>
        <div class="user_type">
            <%=person.getType() == 1 ? "customer" : "admin"%>
        </div>
        <%--Shopping cart--%>
        <div class="shopping_car">
            <a href="shop.jsp">
                <img src="img/shop.jpg" alt="商城" width="50" height="50">
            </a>
        </div>
        <div class="user_type">
            shopping
        </div>
    </div>
</div>


</body>
</html>
