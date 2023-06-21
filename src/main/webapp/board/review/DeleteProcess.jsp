<%@page import="utils.JSFunction"%>
<%@page import="review.reviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
int num = Integer.parseInt(request.getParameter("num"));
reviewDAO dao = new reviewDAO(application);
int rs = dao.deletePost(num);
dao.close();

if(rs == 0){
	JSFunction.alertBack("삭제 실패", out);
}else{
	JSFunction.alertLocation("삭제 되었습니다", "review.jsp", out);
}
%>