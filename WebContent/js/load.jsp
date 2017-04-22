<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="org.json.simple.*"%>
<%@ page import="java.sql.*" %>

<%
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql;
	String callback = request.getParameter("callback");
	
	try{
		String url="jdbc:mariadb://localhost:33060/test";
		String did = "root";
		String dpw = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, did, dpw);
		sql = "select * from mysns_post order by pid desc";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	}catch(Exception e){e.printStackTrace();}
	JSONObject obj = null;
	JSONArray arr = new JSONArray();
	while(rs.next()){
		obj = new JSONObject();
		obj.put("id", rs.getObject("pid"));
		obj.put("subject", rs.getObject("psubject"));
		obj.put("content", rs.getObject("pcontent"));
		obj.put("writer", rs.getObject("pwriter"));
		obj.put("writedate", rs.getObject("pwritedate"));
		arr.add(obj);
	}
	obj = new JSONObject();
	obj.put("data", arr);
	obj.put("result", "success");
	
	String jsonSt = obj.toJSONString();
	out.println(callback + "(");
	out.println(jsonSt);
	out.println(")");
%>


