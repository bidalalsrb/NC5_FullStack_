<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="${pageContext.request.contextPath }/header.jsp"></jsp:include>
	<div
		style="display: flex; flex-direction: column; justify-content: center; align-items: center;">
		<h3>게시글 목록</h3>
		<form id="searchForm" action="/board/getBoardList.do" method="post">
			<table border="1" style="width: 700px; border-collapse: collapse;">
				<tr>
					<td align="right"><select name="searchCondition">
							<option value="all">전체</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="writer">작성자</option>
					</select> <input type="text" name="searchKeyword">
						<button type="submit" id="btnSearch">검색</button></td>
				</tr>
			</table>
		</form>

		<table id="boardTable" border="1"
			style="width: 700px; border-collapse: collapse;">
			<tr>
				<th style="background: skyblue; width: 100px;">번호</th>
				<th style="background: skyblue; width: 200px;">제목</th>
				<th style="background: skyblue; width: 150px;">작성자</th>
				<th style="background: skyblue; width: 150px;">등록일</th>
				<th style="background: skyblue; width: 100px;">조회수</th>
			</tr>
			<tr id="dataTr">

			</tr>
		</table>
		<br /> <a href="/board/insertBoard.do">새 글 등록</a>
	</div>
	<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			$.ajax({
				url: "/board/getBoardListAjax.do",
				type: "post",
				sucess: (obj) =>{
					console.log(obj);
					//jsonString을 json형태의 데이터로 변환
					const jsonObj = JSON.parse(obj);
					console.log(jsonObj);
					
					//받아온 데이터 화면에 출력
					let htmlstr = "";
					
					for(let i =0;i<jsonObj.boardList.length; i++){
						htmlStr += "<tr id='dateTr'>";
						htmlStr += "	<td>" + jsonObj.boardList[i].boardNo + "</td>";
						htmlStr += "<td>";
						htmlStr += "	<a href='/board/updateBoardCnt.do?boardNo='"
								+ jsonObj.boardList[i].boardNo + ">"
								+ jsonObj.boardList[i].boardTitle + "</a>";
						htmlStr += "</td>";
						htmlStr += "	<td>" + jsonObj.boardList[i].boardWriter + "</td>";
						htmlStr += "	<td>" + jsonObj.boardList[i].boardRegdate + "</td>";
						htmlStr += "	<td>" + jsonObj.boardList[i].boardCnt + "</td>";
						htmlStr += " 	</tr>";
						} 	
					
					console.log(htmlStr);
					//기존 dataTr 삭제
					$("#dataTr").remove();
					//테이블에 새로 만든 tr 붙이기
					$("#boardTable").append(htmlStr);
				},
				error: (error) =>{
					console.log(error);
				}
			});
		});
	
	
	
	
	
	
	</script>

</body>
</html>