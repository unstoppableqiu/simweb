<%--
  Created by IntelliJ IDEA.
  User: flyout
  Date: 2018/1/30
  Time: 下午6:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<html>
  <head>
    <title>Index</title>
  </head>
  <body>
  <%= "basic request info"%>
  <% for (int fontSize = 0; fontSize < 3; fontSize++) {%>
    <font color="#7fffd4" size="<%= fontSize%>">Tutorial Point</font>
    <br />
  <%}%>
  Your IP is
  <%=
    request.getRemoteAddr() + "hh"
  %>
  <br />
  Your sessionId is
  <%= session.getId()%>
  <br />
  </body>
</html>
