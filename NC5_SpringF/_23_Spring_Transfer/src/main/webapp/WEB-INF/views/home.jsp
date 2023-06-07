<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<form action="/test3.do" method="get">
		<input type="text" name="name"> <input type="text" name="tel">
		<input type="submit" value="전송">

	</form>
	<div>
		<!-- jsp에서 자바 데이터를 사용할 때는 EL표기법 ${} 사용 -->
		<p>"${nm}"</p>
		<p>"${telNum}"</p>
	</div>
</body>
</html>
