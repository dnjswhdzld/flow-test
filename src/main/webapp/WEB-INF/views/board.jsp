<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
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
		min-width: 300px;
	    min-height: 200px;
	    max-width: 300px;
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
		font-size: 15px;
		width:80px;
		padding:5px 10px;
		border:1px solid #000;
		border-radius: 5px;
		transition: 0.3s;
		box-sizing:border-box;
	}
	.boardSide span:hover{
		background-color: #eaeaea;
	}
	
	.boardCenter {
		width: 325px;
		display: flex;
		border: 1px solid;
		border-radius: 10px;
	}
	
	.boardContent{
		padding: 10px;
		font-size: 20px;
	}
	.boardContent h4{
		margin: 15px 0 ;
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
	.fileupload {
		display: none;
	}
</style>

<script type="text/javascript">
	
	// 파일 확장자 체크
	function inputFileCheck(file){
		var fileValue = file;
		var fileSize = Math.ceil(fileValue[0].size / (1024 * 1024));
		var fileCheck = true;
		
		
		
		if ($('.fileupload').val() != '') {
			
			var fileNameSplit = $('.fileupload').val().split('.');
			var fileName = fileNameSplit[fileNameSplit.length-1];
			
			$.ajax({
				url:"selectExtension",
				type:"POST",
			}).done(function(data){
				$.each(data,function(index,element){
					
					if (element.extension_name == fileName && element.use_yn != 'U') {
						fileCheck = false;
						$('.fileupload').val('');
						alert(fileName+'은(는) 지원하지 않는 파일 확장자 입니다.');
						
					}
				});
				if (fileCheck) {
					var input_fileBox = '<div class="fileDiv"><img><span class="fileName">'+fileValue[0].name+'</span><span class="fileSize">'+fileSize+'Mb</span><a class="fileDel">삭제</a></div>';
					$('.fileBox').append(input_fileBox);
				}
			
			}).fail(function(err){
				alert('에러');
			});
			
		}
	}
	
	// 파일 삭제
	$(document).on('click','.fileDel',function(){
		 if (confirm("등록된 파일을 삭제하시겠습니까?")){  
			$(this).parent().prev().remove();
			$(this).parent().remove();
			initBoard();	
		 }else{   
			 alert('취소되었습니다.');
		 }
	});
	
	// 파일 추가
	$(document).on('click','.upfile',function(){
		if ($('.fileupload').val() == '') {
			$('.fileupload').click();
		}
	});

	// 보드 인설트
	function boardInsert(){
		var boardTitle = $('.contentTitle').val();
		var boardContent =  $('.contentArea').val();
		var boardFileName = $('.fileName').text();
		var boardFileRealPath = '/usr/local/tomcat/webapps/Flowtest/uploadfile/'+$('.fileName').text();
		var boardFileSize = $('.fileSize').text();
		var data = {
				flowboard_title : boardTitle,
				flowboard_content : boardContent,
				flowboard_filename : boardFileName,
				flowboard_filepath : boardFileRealPath,
				flowboard_size : boardFileSize
		};
		
		$.ajax({
			url:"insertBoard",
			type:"POST",
			data:data
		}).fail(function(){
			alert('에러');
		});
		
	}
	
	// 초기화
	function initBoard(){
		$('.contentTitle').val('');
		$('.contentArea').val('');
		$('.fileupload').val('');
		$('.fileDiv').remove();
	}
	
	// 게시글 확인 취소
	$(document).on('click','.boardBtn',function(){
		var btn = $(this).text();
		
		if (btn == '확인') {
			if ($('.contentTitle').val() == '') {
				alert('제목을 입력해주세요.')
			} else if ($('.contentArea').val() == '') {
				alert('내용을 입력해주세요.')
			} else {
				boardInsert();
				$('#fileForm').submit();
				initBoard();
			}
		} else if (btn == '취소') {
			initBoard();
		}
		
	});

	$(document).on('click','.extensionSet',function(){
		location.href="extension";
	});
	
	$(document).on('click','.fileList',function(){
		location.href="boardlist";
	});
	
</script>
</head>
<body>
	
	<div class="boardCenter">
		<div class="boardContent">
			<ul>
				<li>
					<h4>파일 업로드</h4>
				</li>
				<li>
					<input class="contentTitle" type="text" placeholder="제목을 입력해주세요."/>
				</li>
				<li>
					<textarea class="contentArea" placeholder="내용을 입력해주세요."></textarea>
				</li>
				<li class="fileBox">
					<form id="fileForm" method="post" action="fileUpload" enctype="multipart/form-data">
						<input type="file" class="fileupload" name="upload_file" onchange="inputFileCheck(this.files)">
					</form>
				</li>
				<li class="boardBtn">
					<button class="upfile">파일 추가</button><button class="boardBtn">취소</button><button class="boardBtn">확인</button>
				</li>
			</ul>
		</div>
	</div>
	<div class="boardSide">
		<ul>
			<li>
				<span class="fileList">파일 리스트 보기</span>
			</li>
			<li>
				<span class="extensionSet">확장자 설정 하기</span>
			</li>
		</ul>
	</div>
</body>
</html>