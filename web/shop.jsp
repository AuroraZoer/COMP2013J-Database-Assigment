<%--
  Created by IntelliJ IDEA.
  User: 张子毅
  Date: 2023/4/21
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--session事件--%>
<%--=========================================================================================================================================--%>
<%--no session--%>
<%
    if (session.isNew()){
        session.setAttribute("login_status", "true");
    }
%>

<%--recv session msg--%>
<%
    String uid = (String)session.getAttribute("uid");
    String login_status = (String) session.getAttribute("login_status");
%>

<%--session outdate--%>
<%
    if (session.getMaxInactiveInterval()<0){
        session.setAttribute("login_status", "true");
    }
%>

<%--sessionn update--%>
<%
    session.setMaxInactiveInterval(1800);
%>

<%--recv parameters--%>
<%
    String select = request.getParameter("select");
    String keyword = request.getParameter("keyword");
%>

<%--check parameters invalid--%>
<%
    if (select==null){
        select = "null";
    }
    if (keyword==null){
        keyword = "";
    }
%>

<%--parameters react--%>
<%
    if (select.equals("true")){

    }
    if (!keyword.equals("")){
//        ask mysql
    }
%>


<%--change session msg by param--%>
<%

%>

<%--check session msg--%>
<%
    if (uid == null){
        login_status = "false";
    }
%>

<%--change session--%>
<%
    session.setAttribute("referenced", "shop");
%>

<%--pre-action--%>
<%
    if (!login_status.equals("true")){
        response.sendRedirect("login.jsp");
    }
%>

<%--页面事件--%>
<%--========================================================================================================================================--%>




<html>
<head>
    <title>Shop</title>
    <link rel="stylesheet" href="css/shop.css">
    <script type="text/javascript" language="javascript">
        document.getElementById("select_button").onclick = function (){
        //     onclick事件
            
        }
    </script>



</head>
<body>

<div class="whole">
    <div class="left_box">
        <div class="left_box_item">
            <span>item1</span><br>
            <span>item2</span><br>
            <span>item3</span><br>
            <span>item4</span><br>
            <span>item5</span><br>

        </div>
    </div>
    
    <div class="mid_box">
        <div class="top_box">
            <div class="outer_search_box">
                <div class="inner_search_box">
                    <form action="shop.jsp">
                        <label>
                            <input type="search" name="keyword" width="300px" height="50px" spellcheck="false" placeholder="请输入你的商品">
                        </label>
                        <button type="submit">
                            <img src="img/search_icon.png" alt="搜索"， width="50px" height="50px">
                        </button>
                    </form>
                </div>
            </div>
            
            <div class="select">
                <form action="shop.jsp" method="post">
                    <input type="hidden" name="select" value="true">
                <button id="select_button" type="submit">
                <img src="img/select_icon.jpg" alt="筛选" height="50" width="50">
                </button>
                </form>
            </div>
        </div>
        
    </div>
    
    
<%--    用户界面--%>
    <div>
        <a href="userMain.jsp">
            <img src="img/user_icon.jpg" alt="用户" height="50" width="50">
        </a>
    </div>

<%--    购物车--%>

    <div>
        <a href="shopping_car.jsp">
            <img src="img/shopping_car.jpg" alt="购物车" height="50" width="50">
        </a>
    </div>
    
    
    
</div>



</body>
</html>
