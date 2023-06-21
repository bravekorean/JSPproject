<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileUploadException"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="utils.JSFunction"%>
<%@page import="javax.print.attribute.standard.JobHoldUntil"%>
<%@page import="review.reviewDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.File" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("UserId");
	String review_title="";
	String review_content="";
	int ratingValue=0;
	String artwork_title="";
	String fileName="";
	InputStream fileContent = null;
	
	reviewDAO dao = new reviewDAO(application);
	
    // Check if the request contains multipart content
    if (ServletFileUpload.isMultipartContent(request)) {
        // Create a DiskFileItemFactory
        DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();

        // Set the temporary directory for storing uploaded files
        fileItemFactory.setRepository(new File(getServletContext().getRealPath("/board_temp")));

        // Create a ServletFileUpload instance
        ServletFileUpload fileUpload = new ServletFileUpload(fileItemFactory);

        try {
            // Parse the request to get a list of FileItem objects
            List<FileItem> fileItems = fileUpload.parseRequest(new ServletRequestContext(request));

            // Process each FileItem
            for (FileItem fileItem : fileItems) {
                if (fileItem.isFormField()) {
                	request.setCharacterEncoding("UTF-8");
                    // Process regular form field
                    String fieldName = fileItem.getFieldName();
                    String fieldValue = fileItem.getString();
                    if (fieldName.equals("title")) {
                        review_title = new String(fieldValue.getBytes("8859_1"),"utf-8");
                    } else if (fieldName.equals("content")) {
                    	review_content = new String(fieldValue.getBytes("8859_1"),"utf-8");
                    } else if (fieldName.equals("ratingValue")) {
                    	ratingValue = Integer.parseInt(fieldValue);
                    } else if (fieldName.equals("title_artwork")) {
                    	artwork_title = new String(fieldValue.getBytes("8859_1"),"utf-8");
                    }
                    
                } else {
                    // Process uploaded file
                    String fieldName = fileItem.getFieldName();
                    fileName = fileItem.getName();
                    String contentType = fileItem.getContentType();
                    fileContent = fileItem.getInputStream();
                    
                }

            }
            	response.setCharacterEncoding("UTF-8");
               	boolean result = dao.addReview(artwork_title, review_title, review_content, id, ratingValue, fileName, fileContent);
               	if(result){
               		JSFunction.alertLocation("작성 되었습니다.", "review.jsp", out);
               	}
               	else {
               		JSFunction.alertBack("실패 하셨습니다.", out);
               	}
            
        } catch (FileUploadException e) {
            // Handle FileUploadException
            e.printStackTrace();
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
        }
    }
%>
