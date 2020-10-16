<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>extension</title>
<script type="text/javascript" ></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style type="text/css">
	.wrapper{
		width: 700px;
		border: 1px solid;
   	 	padding: 20px;
   	 	border-radius: 10px;
	}
	::-webkit-scrollbar { 
		display: none;
	}

	ul {
		list-style: none;
		margin: 0px;
	}
	li {
		padding:10px 0;
	}
	.sidetag {
		float: left;
		font-weight:700;
	}
	.sidetag span{
		padding: 10px 0;
		display: inherit;
	}
	.extension {
		margin-left:100px;
	}
	.extension_input {
	    height: 20px;
		border: 1px solid;
		border-radius: 5px;
	}
	.extension_box {
		border: 1px solid;
		border-radius: 5px;
		height:400px;
	}
	.extension_count {
		padding: 5px 0 0 5px;
	}
	.extension_count_a {
		padding-top: 5px;
	}
	
	.extension_list div{
		margin:5px;
		border: 1px solid #000;
		background:#ccc;
	    padding: 4px 8px;
	    border-radius: 4px;
		float: left;
		
	}
	
	.extension_list {
	    height: 95%;
    	overflow-y: scroll;
	}
	.extension_list .del_btn {
		cursor:pointer;
		margin-left: 10px;
	}
	
	.fileboard,.fileboardlist {
		display:inline-block;
		margin:10px 0 0 0;
		padding:10px;
		border-radius:4px;
		background:#ccc;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		extensionCount();
		
		$('.extension_input').keypress(function(e){
		     if (e.which == 13) {
		         $('.add_extension').click();
		     }
		});
	});
	
	// 확장자 카운트
	function extensionCount(){
		var extension_count = 0;
		$('.extension_list').find('.extension_name').each(function(){
			extension_count++;
		});
		$('.extension_count').text(extension_count);
	};
	
	// 기본 확장자 이벤트
	$(document).on('click','.default',function(){
		var defaultExtension = $(this).val();
		if ($(this).is(':checked') == true) {
			defaultUpdateExtension(defaultExtension,'C');
		} else if ($(this).is(':checked') == false) {
			defaultUpdateExtension(defaultExtension,'U');
		}
	});
	
	function defaultUpdateExtension(setting,check){
		var data = {
			extension_name : setting,
			extension_type : 'D',
			use_yn : check
		};
		$.ajax({
			url:"updateDefaultExtension",
			type:"POST",
			data:data
		}).fail(function(err){
			alert('에러');
		});
	}
	
	// 중복 확인 함수
	function checkExtension(){
		var checked = true;
		var customExtension = $('.extension_input').val().toLowerCase();
		$('.extension_name').each(function(){
			if ($(this).text().trim() == customExtension) {
				checked = false;
			}
		});
		return checked;
	}
	
	// 커스텀 확장자	
	$(document).on('click','.add_extension',function(){
		var max_count = $('.extension_count').text(); // 총 확장자 수
		var customExtension = $('.extension_input').val().toLowerCase(); // 커스텀 확장자 입력 값
		var regularExpression = inputCheck(customExtension);
		if (max_count >= 200) {
			alert('커스텀 확장자는 최대 200개까지 추가 가능합니다.');
		} else if(regularExpression == false){
			alert('특수문자와 숫자는 입력할 수 없습니다.');
		} else if (customExtension == '') {
			alert('확장자를 입력해주세요.');
		} else {
			
			var duplicate = checkExtension();
			if (duplicate == true) {
				var data = {
						extension_name : customExtension,
						extension_type : 'C'
				};
				$.ajax({
					url:"insertExtension",
					type:"POST",
					data:data
				}).done(function(){
					var appendExtension = '<div><span class="extension_name">'+customExtension+'</span><span class="del_btn">X</span></div>';
					$('.extension_list').append(appendExtension);
					extensionCount();
				}).fail(function(){
					alert('에러');
				});
			} else if (duplicate == false) {
				alert('중복 된 확장자가 있습니다.');
			}
		}
		$('.extension_input').val('');
	});
	
	

	// 확장자 삭제
	$(document).on('click','.del_btn',function(){
		var selectExtension = $(this);
		var extensionName = $(this).prev().text().trim();
		var data = {
				extension_name : extensionName
		};
		
		$.ajax({
			url:"deleteExtension",
			type:"POST",
			data:data
		}).done(function(){
			selectExtension.parent().remove();
			extensionCount();
		}).fail(function(err){
			alert('에러');
		});
		
	});
	
	// 특수문자 숫자 유효성검사
	function inputCheck(data){
		var eng = /^[a-zA-Z]*$/;

		if(eng.test(data)){
			return true; 
		} else { 
			return false; 
		}

	}
	
	$(document).on('click','.fileboard',function(){
		location.href="board";
	});
	$(document).on('click','.fileboardlist',function(){
		location.href="boardlist";
	});
	</script>
</head>
<body>
<h2>파일 확장자 차단</h2>
<div class='wrapper'>

	<div class="sidetag">
		<span>
			고정 확장자
		</span>
		<span>
			커스텀 확장자
		</span>
	</div>
	<div class="extension">
	<ul>
			<li>
			<c:forEach var="defaultExtension" items="${defaultExtensionList}">
				<c:choose>
					<c:when test="${defaultExtension.use_yn eq 'U'}">
						<label class="extension_name">
							<input class="default" type="checkbox" value="${defaultExtension.extension_name}">${defaultExtension.extension_name}
						</label>
					</c:when>
					<c:otherwise>
						<label class="extension_name">
							<input class="default" type="checkbox" value="${defaultExtension.extension_name}" checked="checked">${defaultExtension.extension_name}
						</label>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</li>
			<li>
				<span>
					<input class="extension_input" type="text" placeholder="확장자 입력" maxlength="20">
				</span>
				<span>
					<button class="add_extension">+추가</button>
				</span>
			</li>
			<li>
				<div class="extension_box">
					<span class="extension_count"></span><span class="extension_count_a">/200</span>
					<div class="extension_list">
						<c:forEach var="customExtension" items="${customExtensionList}">
							<c:if test="${customExtension.extension_type eq 'C'}">
								<div>
									<span class="extension_name">${customExtension.extension_name}</span><span class="del_btn">X</span>
								</div>
							</c:if>
						</c:forEach>						
					</div>
				</div>
			</li>
		</ul>
	</div>
		
	</div>
	<span class="fileboard">
		파일 업로드 하기
	</span>
	<span class="fileboardlist">
		파일리스트 보기
	</span>
</body>
</html>