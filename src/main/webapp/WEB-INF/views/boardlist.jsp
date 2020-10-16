<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
	body {
		width: 700px;
		height: 600px;
	}
	ul {
		list-style: none;
		padding: 0px;
		margin: 0px;
	}
	textarea {
		min-width: 295px;
	    max-width: 295px;
	    max-height: 300px;
	}
	.boardSide{
		float: left;
		width: 150px;
		text-align: center;
	}
	.boardSide li{
		margin: 20px 0;
	}
	.boardSide span{
		cursor:pointer;
		font-size: 20px;
	}
	.boardSide span:hover{
		background-color: #eaeaea;
		padding:5px 10px;
		border-radius: 5px;
	}
	.uldiv{
		border: 1px solid;
	}
	.boardListCenter {
	    min-height: 300px;
		width:325px;
		flex-direction: column;
		display: flex;
		border: 1px solid;
		border-radius: 10px;
	}
	
	.boardList{
		padding: 10px;
		font-size: 20px;
	}
	.boardList h4{
		margin: 15px 10px ;
	}
	
	.contentTitle {
		width: 300px;
		margin-bottom: 15px;
    	height: 25px;
	}
	
	.boardBtn {
		float: right;
	}
	.boardBtn button{
		margin:5px;
	}
	.fileDiv {
		border: 1px solid;
		height: 50px;
		font-size: 15px;
		margin-bottom: 5px;
	}
	.fileDiv img{
		height: 30px;
    	width: 30px;
   		margin: 10px 0 0 10px;
   		float: left;
	}
	.fileDiv span{
   		float: left;
   		position: absolute;
   		margin-left: 10px;
	}
	.fileName {
		margin-top: 5px;
	}
	
	.fileSize {
		margin-top: 25px;
	}
	
	.fileDel {
		float: right;
		margin: 5px;
	}
	
	#filedown{
		float: right;
		margin: 15px 10px 0 0;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	$(document).on('click','.extensionSet',function(){
		location.href="extension";
	});
	
	$(document).on('click','.fileupload',function(){
		location.href="board";
	});
</script>
</head>
<body>
	<div class="boardSide">
		<ul>
			<li>
				<span class="fileupload">파일 업로드</span>
			</li>
			<li>
				<span class="extensionSet">설정</span>
			</li>
		</ul>
	</div>
	<div class="boardListCenter">
		<c:forEach var="boardList" items="${boardList}">
			<div class="boardList">
				<div class="uldiv">
					<ul>
						<li>
							<h4>${boardList.flowboard_title}</h4>
						</li>
						<li>
							<textarea class="contentArea" readonly="readonly">${boardList.flowboard_content}</textarea>
						</li>
						<c:if test="${boardList.flowboard_filepath ne null}">
							<li class="fileBox">
								<div class="fileDiv">
									<span class="fileName">${boardList.flowboard_filename}</span>
									<span class="fileSize">${boardList.flowboard_size}</span>
			<!-- 						<a id="filedown">다운로드</a> -->
								</div>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>