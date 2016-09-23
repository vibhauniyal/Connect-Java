<%@page import="java.util.Enumeration"%>
<%@ page session="true" %>
<%
    out.println("Hello ...\n" + (String)session.getAttribute("mname"));
Enumeration keys = session.getAttributeNames();
while (keys.hasMoreElements())
{
  String key = (String)keys.nextElement();
  out.println(key + ": " + session.getValue(key) + "<br>\n");
}
int ran = (int)(Math.random()* 90 + 10);
session.setAttribute("A"+ran, ""+ran);
session.setAttribute("mname", "Sandeep");
%>
