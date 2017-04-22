<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.*"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql;
	int x = 0;
	JSONObject obj = null;
	try{
		String url="jdbc:mariadb://localhost:33060/test";
		String did = "root";
		String dpw = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, did, dpw);

		sql = "insert into mysns_account(mid, mpw) values (?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		x = pstmt.executeUpdate();
	}catch(Exception e){e.printStackTrace();}
	
	if(x == 1){
		obj = new JSONObject();
		obj.put("result", "success");
	}
	String jsonSt = obj.toJSONString();
	String callback = request.getParameter("callback");
	out.println(callback + "(");
	out.println(jsonSt);
	out.println(")");
	
%>
