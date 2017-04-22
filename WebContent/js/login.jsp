<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.*"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");	
	
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql;
	String callback = request.getParameter("callback");
	
	try{
		String url="jdbc:mariadb://localhost:33060/test";
		String did = "root";
		String dpw = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		con = DriverManager.getConnection(url, did, dpw);
		sql = "select * from mysns_account where mid=? and mpw=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		rs = pstmt.executeQuery();
	}catch(Exception e){e.printStackTrace();}
	JSONObject obj = null;
	
	if(rs.next()){
		obj = new JSONObject();
		obj.put("result", "success");
	}
	String jsonSt = obj.toJSONString();
	
	out.println(callback + "(");
	out.println(jsonSt);
	out.println(")");
%>


