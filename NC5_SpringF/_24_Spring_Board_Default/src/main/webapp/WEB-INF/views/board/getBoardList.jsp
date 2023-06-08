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
		<h3>게시글 목록</h3>
		<form id="searchForm" action="/board/getBoardList.do" method="post">
			<table border="1" style="width: 700px; border-collapse: collapse;">
				<tr>
					<td align="right">
						<select name="searchCondition">
							<option value="all">전체</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
						</select>
						<input type="text" name="searchKeyword">
						<button type="submit" id="btnSearch">검색</button>
					</td>
				</tr>
			</table>
		</form>
		
		<table id="boardTable" border="1" style="width: 700px; border-collapse: collapse;">
			<tr>
				<th style="background: skyblue; width: 100px;">번호</th>
				<th style="background: skyblue; width: 200px;">제목</th>
				<th style="background: skyblue; width: 150px;">작성자</th>
				<th style="background: skyblue; width: 150px;">등록일</th>
				<th style="background: skyblue; width: 100px;">조회수</th> 
			</tr>
			<tr>
				<td>1</td>
				<td>
					제목
				</td>
				<td>작성자</td>
				<td>
					2023-06-08
				</td>
				<td>0</td>
			</tr>
		</table>
		<br/>
		<a href="#">새 글 등록</a>
	</div>
	<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
</body>
</html>