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
	
	// 파일 업로드
	$(document).on('click','.fileboard',function(){
		location.href="board";
	});