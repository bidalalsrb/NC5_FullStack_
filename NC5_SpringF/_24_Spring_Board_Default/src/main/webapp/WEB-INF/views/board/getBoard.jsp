<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<div style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
		<h3>게시글 상세</h3>
		<form action="#" method="post">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="background: skyblue; width: 70px">
						제목
					</td>
					<td style="text-align: left">
						<input type="text" name="boardTitle" id="boardTitle">
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						작성자
					</td>
					<td style="text-align: left">
						<input type="text" name="boardWriter" id="boardWriter" readonly>
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						내용
					</td>
					<td style="text-align: left">
						<textarea name="boardContent" id="boardContent" cols="40" rows="10"></textarea>
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						작성일
					</td>
					<td style="text-align: left">
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						조회수
					</td>
					<td style="text-align: left">
						
					</td>
				</tr>
				<tr id="btnWrap">
					<td colspan="2" align="center">
						<button type="submit" id="btnUpdate">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<hr/>
		<a href="#">글 등록</a>
		<a href="#" id="deleteBtn">글 삭제</a>
		<a href="#">글 목록</a>
	</div>
	<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
</body>
</html>