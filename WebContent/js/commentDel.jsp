<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.*"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String postId = request.getParameter("postId");
	
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql;
	String callback = request.getParameter("callback");
	int cnt = 0;
	try{
		String url="jdbc:mariadb://localhost:33060/test";
		String did = "root";
		String dpw = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, did, dpw);
		
		sql = "delete from mysns_comment where pid=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, postId);
		cnt = pstmt.executeUpdate();
	}catch(Exception e){e.printStackTrace();}
	JSONObject obj = null;
	
	if(cnt > 0){
		obj = new JSONObject();
		obj.put("result", "success");
	}
	String jsonSt = obj.toJSONString();
	
	out.println(callback + "(");
	out.println(jsonSt);
	out.println(")");
%>


