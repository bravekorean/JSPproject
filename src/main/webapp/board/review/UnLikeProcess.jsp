<%@page import="utils.JSFunction"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String id = (String)session.getAttribute("UserId");
int num = Integer.parseInt(request.getParameter("num"));
reviewDAO dao = new reviewDAO(application);
dao.updateLikeCount(num, 0);
dao.close();
session.setAttribute(id+num, null);
response.sendRedirect("View.jsp?num="+num);
%>