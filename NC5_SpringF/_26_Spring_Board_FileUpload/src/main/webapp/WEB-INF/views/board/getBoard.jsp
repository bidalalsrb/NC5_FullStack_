<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<form id="updateForm" action="/board/updateBoard.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="boardNo" id="boardNo" value="${board.boardNo }">
			<input type="hidden" name="originFiles" id="originFiles">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="background: skyblue; width: 70px">
						제목
					</td>
					<td style="text-align: left">
						<input type="text" name="boardTitle" id="boardTitle" value="${board.boardTitle }">
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						작성자
					</td>
					<td style="text-align: left">
						<input type="text" name="boardWriter" id="boardWriter" value=${board.boardWriter } readonly>
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						내용
					</td>
					<td style="text-align: left">
						<textarea name="boardContent" id="boardContent" cols="40" rows="10">${board.boardContent }</textarea>
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						작성일
					</td>
					<td style="text-align: left">
						${board.boardRegdate }
					</td>
				</tr>
				<tr>
					<td style="background: skyblue;">
						조회수
					</td>
					<td style="text-align: left">
						${board.boardCnt }	
					</td>
				</tr>
				<tr>
					<td style="background: skyblue; width:70px;">
						첨부파일
					</td>
					<td style="text-align: left;">
						<div id="image_preview">
							<input type="file" id="btnAtt" name="uploadFiles" multiple>
							<input type="file" id="changedFiles" name="changedFiles" 
							style="display:none;" multiple>
							<p style="color: red; font-size:0.9rem;">
								파일을 변경하려면 사진을 파일을 다운로드하려면 파일명을 클릭하세요.
							</p>
							<div id="attZone">
								<c:forEach items="${boardFileList }" var="boardFile" 
								varStatus="status">
									<div style="display: inline-block; 
									position: relative; width: 150px; height: 120px;
									margin: 5px; border: 1px solid #00f; z-index: 1;">
									<input type="hidden" id="boardNo${status.index }" 
										   value="${boardFile.boardNo }">
									<input type="hidden" id="boardFileNo${status.index }" 
										   value="${boardFile.boardFileNo }">
									<input type="hidden" id="boardFileName${status.index }" 
										   value="${boardFile.boardFileName }">
									<input type="file" 
										id="changedFile${boardFile.boardFileNo }"
										name="changedFile${boardFile.boardFileNo }" 
										style="display: none;"
										onchange="fnGetChangedFileInfo(${boardFile.boardFileNo }, event)">
									
									<c:if test="${status.last }">
										<input type="hidden" id="boardFileCnt" 
										name="boardFileCnt" value="${status.count }">
									</c:if>
										<c:choose>
											<c:when test="${boardFile.boardFileCate eq 'image' }">
												<img id="img${boardFile.boardFileNo }"
												src="/upload/${boardFile.boardFileName }"
												style="width: 100%; height: 100%; z-index: none; 
												cursor: pointer;" class="fileImg" 
												onclick="fnImageChange(${boardFile.boardFileNo})">
											</c:when>
											<c:otherwise>
												<img id="img${boardFile.boardFileNo }"
												src="/images/defaultFileImg.png"
												style="width: 100%; height: 100%; z-index: none; 
												cursor: pointer;" class="fileImg"
												onclick="fnImageChange(${boardFile.boardFileNo})">
											</c:otherwise>
										</c:choose>
										<input type="button" class="btnDel" value="x" 
										delFile="${boardFile.boardFileNo }" 
										style="width: 30px; height: 30px; position: absolute;
										right: 0px; bottom: 0px; z-index= 999; 
										background-color: rgba(255, 255, 255, 0.1)
										color: #f00;" onclick="fnImgDel(event)">
										<p id="fileName${boardFile.boardFileNo }"
										style="display: inline-block; 
										font-size: 8px; cursor: pointer;"
										onclick="fnFileDown(${boardFile.boardNo }, ${boardFile.boardFileNo })">
											${boardFile.boardFileName }
										</p>
									</div>
								</c:forEach>
							</div>
						</div>
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
		<a href="/board/insertBoard.do">글 등록</a>
		<a href="/board/deleteBoard.do?boardNo=${board.boardNo }" id="btnDelete">글 삭제</a>
		<a href="/board/getBoardList.do">글 목록</a>
	</div>
	<jsp:include page="${pageContext.request.contextPath }/footer.jsp"></jsp:include>
	<script>
		//추가된 파일을 담아줄 배열
		const uploadFiles = [];
		//기존 첨부파일 배열
		const originFiles = [];
		//변경된 첨부파일 배열
		const changedFiles = [];
	
		$(function() {
			//세션, 리퀘스트, 모델에 담긴 값을 javascript에서 사용
			const loginUser = '${loginUser.userId}';
			const boardWriter = '${board.boardWriter}';
			
			//게시글 작성자와 로그인된 유저가 다르면 수정버튼 숨김
			if(loginUser !== boardWriter) {
				$("#btnUpdate").hide();
				$("#btnDelete").hide();
				$("#boardTitle").attr("readonly", true);
				$("#boardContent").attr("readonly", true);
			}
			
			//input type="file"이 변경되면 미리보기 동작
			$("#btnAtt").on("change", (e) => { 
				//input에 추가된 파일들 변수로 받기
				const files = e.target.files;
				
				//변수로 받아온 파일들 배열로 변환
				const fileArr = Array.prototype.slice.call(files);
				
				//파일 배열에 담긴 파일들 하나씩 꺼내서 미리보기 처리
				for(f of fileArr) {
					//미리보기 메소드 호출
					imageLoader(f);
				}
			});
			
			//기존 첨부되어 있던 파일 배열 생성
			for(let i = 0; i < $("#boardFileCnt").val(); i++) {
				const originFileObj = {
						boardNo: $("#boardNo" + i).val(),
						boardFileNo: $("#boardFileNo" + i).val(),
						boardFileName: $("#boardFileName" + i).val(),
						//수정되면 U, 삭제되면 D
						boardFileStatus: "N"
				}
				
				originFiles.push(originFileObj);
			}
			
			//updateForm 서브밋
			$("#updateForm").on("submit", (e) => {
				//배열담겨있는 파일들을 input으로 옮겨서 submit
				dt = new DataTransfer();
				
				for(f in uploadFiles) {
					let file = uploadFiles[f];
					dt.items.add(file);
				}
				
				$("#btnAtt")[0].files = dt.files;
				
				//수정된 파일들(changedFiles배열) input으로 옮겨담기
				dt2 = new DataTransfer();
				
				for(f in changedFiles) {
					let file = changedFiles[f];
					dt2.items.add(file);
				}
				
				$("#changedFiles")[0].files = dt2.files;
				
				//originFiles 배열을 전송하기 위해 input에 담음
				//javascript 배열을 java에서 받아서 바로 사용 불가능하므로
				//String으로 변경해서 전송한다.
				$("#originFiles").val(JSON.stringify(originFiles));
			});
		});
		
		const fnFileDown = (boardNo, boardFileNo) => {
			window.location = "/board/fileDown.do?boardNo=" 
					+ boardNo + "&boardFileNo=" + boardFileNo; 
		}
		
		//미리보기 메소드
		//미리보기 영역에 들어갈 img 태그 생성 및 선택된 파일을 
		//Base 64 인코딩된 문자열 형태로 변환하여 미리보기 구현
		const imageLoader = (file) => {
			//첨부파일 배열에 추가
			uploadFiles.push(file);
			
			let reader = new FileReader();
			
			reader.onload = (e) => {
				//이미지 표출할 img 태그 생성
				let img = document.createElement("img");
				img.setAttribute("style", "width: 100%; height: 100%; z-index: none;");
				
				//이미지 파일인지 아닌지 체크
				if(file.name.toLowerCase().match(/(.*?)\.(jpg|jpeg|png|gif|svg|bmp)$/)) {
					img.src = e.target.result;
				} else {
					img.src = 'images/defaultFileImg.png';
				}
				
				//미리보기 영역에 추가
				//미리보기 이미지 태그와 삭제 버튼 그리고 파일명을 표출하는 p태그
				//묶어주는 div를 만들어서 미리보기 영역에 추가
				$("#attZone").append(makeDiv(img, file));
			}
			
			//파일을 BASE 64 인코딩 문자열로 변경
			reader.readAsDataURL(file);
		}
	
		//미리보기 영역에 들어갈 div 생성하는 메소드
		const makeDiv = (img, file) => {
			//div 태그 생성
			let div = document.createElement("div");
			
			div.setAttribute("style", "display: inline-block;" 
			+ " position: relative;"
			+ " width: 150px; height: 120px;" 
			+ " margin: 5px; border: 1px solid #00f; z-index: 1");
			
			//잘못 올렸을 경우 삭제할 수 있는 버튼 생성
			let btn = document.createElement("input");
			btn.setAttribute("type", "button");
			btn.setAttribute("value", "x");
			btn.setAttribute("delFile", file.name);
			btn.setAttribute("style", "width: 30px; height: 30px;"
			+ " position: absolute; right: 0px; bottom: 0px;"
			+ " z-index: 999; background-color: rgba(255, 255, 255, 0.1);"
			+ " color: #f00;");
			
			//버튼 이벤트 생성
			//버튼 클릭하면 해당 파일삭제 기능 구현
			btn.onclick = (e) => {
				//클릭된 버튼
				const ele = e.srcElement;
				
				const delFile = ele.getAttribute("delFile");
				
				for(let i = 0; i < uploadFiles.length; i++) {
					//배열에 담겨있는 파일중 파일명이 같은 파일 삭제
					if(delFile === uploadFiles[i].name) {
						//배열에서 i번째 하나 제거
						uploadFiles.splice(i, 1);
					}
				}
				
				//버튼 클릭 시 btnAtt 인풋에서도 첨부된 파일 삭제
				//input type="file"은 첨부된 파일을 fileList의 형태로 관리
				//fileList에는 일반적인 File 객체를 넣을 수 없다.
				//DataTransfer라는 클래스를 이용해서 완전한 fileList 형태로 만들어서
				//input.files에 넣어줘야 한다.
				
				dt = new DataTransfer();
				
				for(f in uploadFiles) {
					const file = uploadFiles[f];
					dt.items.add(file);
				}
				
				$("#btnAtt")[0].files = dt.files;
				
				//해당 img 태그를 담고 있는 div 삭제
				const parentDiv = ele.parentNode;
				$(parentDiv).remove();
			}
			
			//파일명 표출할 p태그 생성
			const fName = document.createElement("p");
			fName.setAttribute("style", "display: inline-block; font-size: 8px;");
			fName.textContent = file.name;
			
			//div에 하나씩 추가
			div.appendChild(img);
			div.appendChild(btn);
			div.appendChild(fName);
			
			//완성된 div 리턴
			return div;
		}
		
		//img 태그 클릭시 숨어있는 input type="file"이 클릭되어
		//첨부파일 팝업이 뜨게 해주는 메소드
		const fnImageChange = (boardFileNo) => {
			//boardFileNo에 해당하는 input type="file"을 가져옴
			const changeFile = 
				document.getElementById("changedFile" + boardFileNo);
			//선택된 input을 강제 클릭
			changeFile.click();
		}
		
		const fnGetChangedFileInfo = (boardFileNo, e) => {
			//변경된 파일 받아오기
			const files = e.target.files;
			
			//받아온 파일 배열로 변경
			const fileArr = Array.prototype.slice.call(files);
			
			//변경된 파일을 changedFilse 배열에 담아줌
			changedFiles.push(fileArr[0]);
			
			//미리보기 화면에서 변경된 파일 출력
			const reader = new FileReader();
			
			reader.onload = function(ee) {
				const img = 
					document.getElementById("img" + boardFileNo);
				const p = 
					document.getElementById("fileName" + boardFileNo);
				
				//이미지인지 체크
				if(fileArr[0].name
						.match(/(.*?)\.(jpg|jpeg|png|gif|bmp|svg)$/))
					img.src = ee.target.result;
				else
					img.src = '/images/defaultFileImg.png';
				
			}
			
			reader.readAsDataURL(fileArr[0]);
			
			//기존 파일 담고있는 배열(originFiles)에서 변경된 파일에 대한 정보 수정
			for(let i = 0; i < originFiles.length; i++) {
				if(boardFileNo == originFiles[i].boardFileNo) {
					originFiles[i].boardFileStatus = "U";
					originFiles[i].newFileName = fileArr[0].name;
				}
			}
		}
		
		//x버튼 클릭시 동작하는 메소드
		const fnImgDel = (e) => {
			//클릭된 태그 가져오기
			const ele = e.srcElement;
			//delFile속성 가져오기
			const delFile = ele.getAttribute("delFile");
			
			for(let i = 0; i < originFiles.length; i++) {
				if(delFile == originFiles[i].boardFileNo) {
					originFiles[i].boardFileStatus = "D";
				}
			}
			
			//부모요소인 div 삭제
			const div = ele.parentNode;
			$(div).remove();
		}
		
		
		
		
		
		
		
		
		
		
	</script>
</body>
</html>