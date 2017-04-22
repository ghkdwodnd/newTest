<%@page import="org.json.simple.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	String parent = request.getParameter("parentId");
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	Date d = new Date();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:SS");
	String writedate = format.format(d);
	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	String sql;
	int x = 0;
	JSONObject  obj = null;
	try{
		String url="jdbc:mariadb://localhost:33060/test";
		String did = "root";
		String dpw = "1234";
		
		Class.forName("org.mariadb.jdbc.Driver");
		conn = DriverManager.getConnection(url, did, dpw);
		sql = "insert into mysns_comment(pparent, pcontent, pwritedate, pwriter) values (?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, parent);
		pstmt.setString(2, content);
		pstmt.setString(3, writedate);
		pstmt.setString(4, writer);
		x = pstmt.executeUpdate();
		sql = "select max(pid) from mysns_comment";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
	}catch(Exception e){e.printStackTrace();}
	JSONArray jArray = new JSONArray();
	if(x == 1){
		obj = new JSONObject();
		obj.put("result", "success");
		
	}
	if(rs.next()){
		obj.put("lastId", rs.getObject(1));
	}
	
	String jsonSt = obj.toJSONString();
	String callback = request.getParameter("callback");

	out.println(callback + "(");
	out.println(jsonSt);
	out.println(")");
	
%>
