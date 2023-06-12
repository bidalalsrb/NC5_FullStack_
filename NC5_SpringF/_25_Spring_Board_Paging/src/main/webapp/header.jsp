<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	ul, li {
		list-style: none;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	a:hover {
		color: blue;
	}
	
	.main-div li a {
		font-size: 1.125rem;
	}
	
	.user-nav {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	
	.user-nav li {
		margin-left: 10px;
	}
	
	.user-nav li a {
		font-size: 0.9rem;
	}
</style>
<script src="${pageContext.request.contextPath }/js/jquery-3.7.0.min.js"></script>
</head>
<body>
	<header style="display: flex; justify-content: space-between; align-items: center; background: skyblue;">
		<h1>
			<a href="/index.jsp">홈</a>
		</h1>
		<nav>
			<ul class="main-nav">
				<li>
					<a href="/board/getBoardList.do">게시글 목록</a>
				</li>			
			</ul>
		</nav>
		<nav>
			<c:choose>
				<c:when test="${loginUser eq null }">
					<ul class="user-nav">
						<li>
							<a href="/user/login.do">로그인</a>
						</li>
						<li>
							<a href="/user/join.do">회원가입</a>
						</li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul class="user-nav">
						<li>
							${loginUser.userId }
						</li>
						<li>
							<a href="/user/logout.do">로그아웃</a>
						</li>
					</ul>
				</c:otherwise>
			</c:choose>
		</nav>
	</header>
</body>
</html>