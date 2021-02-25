	$(document).ready(function() {
	
		// ##이메일 패턴식 안내
		 $('#emailPattern').show();
	
		// ##아이디 중복 확인 멘트 - hide
		$('#idOk').hide();
		$('#idDup').hide();
		$('#idNull').hide();
		
		// ##아이디 패턴 검사
		$('#idPattern').show();
		$('#idPattern').attr("style", "color:gray");
		
		// ##닉네임 중복 확인 멘트 - hide
		$('#nicknameOk').hide();
		$('#nicknameDup').hide();
		$('#nicknameNull').hide();	
		
		// ##아이디 중복 검사 버튼
		$("#idDupCheck").click(function(e) {
			e.preventDefault();
			var inputId = $('#inputId').val();
						
			$.ajax({
				type: "get",
				url: "/mountain/member/idDupCheck",
				data: {inputId:inputId}
			}).done(function(data) {
				console.log("아이디 중복 검사");
				if(data != null) {
					$('#idNullError').hide();
					if(data == '0' ) {
						console.log("사용할 수 있음");
						$('#idDup').hide();
						$('#idNull').hide();
						$('#idPattern').hide();
						alert("아이디를 사용할 수 있습니다.");
						$("#checkedId").val('y');
						$('#idOk').show();
					} else if(data == '-1') {
						console.log("중복 아이디");
						$('#idOk').hide();
						$('#idNull').hide();
						$('#idPattern').hide();
						alert("중복된 아이디입니다.");
						$('#idDup').show();
					} else if(data == '-2') {
						console.log("아이디 null");
						$('#idDup').hide();
						$('#idNull').hide();
						$('#idPattern').show();
						$('#idPattern').attr("style", "color:tomato");
						$('#idNull').show();
					} else if(data == '-3') {
						console.log("아이디 패턴 x");
						$('#idOk').hide();
						$('#idDup').hide();
						$('#idNull').hide();
						$('#idPattern').show();
						$('#idPattern').attr("style", "color:tomato"); //inputid 패턴식 false
						
					}
				} 
			}).fail(function() {
	
			});
		});
		
  		// ##(아이디 입력 시) 아이디 중복 검사를 해주세요.
		$("#join").click(function(e) {
			e.preventDefault();
			if($("#checkedId").val() == ''){
				alert("아이디 중복 확인을 해주세요.");
		//		 $("input[name='checked_id']").eq(0).focus(); //커서 옮기기
				return false;
			} 
			$("#joinForm1").submit();
		}); 

		// ##닉네임 중복 검사 버튼
		$("#nicknameDupCheck").click(function(e) {
			e.preventDefault();
			var inputNickname = $('#inputNickname').val();
			
			$.ajax({
				type: "get",
				url: "/mountain/member/nicknameDupCheck",
				data: {inputNickname:inputNickname}
			}).done(function(data) {
				console.log("닉네임 중복 검사");
				if(data != null) {
					if(data == '0' ) {
						console.log("사용할 수 있음");
						$('#nicknameDup').hide();
						$('#nicknameNull').hide();
						alert("닉네임을 사용할 수 있습니다.");
						$("#checkedNn").val('y');
						$('#nicknameOk').show();
					} else if(data == '-1') {
						console.log("중복된 닉네임");
						$('#nicknameOk').hide();
						$('#nicknameNull').hide();
						alert("중복된 닉네임입니다.");
						$('#nicknameDup').show();
					} else if(data == '-2') {
						console.log("닉네임 null");
						$('#nicknameOk').hide();
						$('#nicknameDup').hide();
						$('#nicknameNull').show();
					}
				} 
			}).fail(function() {
	
			});
		});
		
		
 		// ##닉네임 중복 검사를 해주세요.
		$("#join").click(function(e) {
			e.preventDefault();
			if($("#checkedNn").val() == ''){
				alert("닉네임 중복 확인을 해주세요.");
				return false;
			} 
			$("#joinForm1").submit();
		});
 		
 		// ##키업 될때, 아이디, 닉네임 중복 확인 필요
 		function setIdReset() {
 			$("#checkedId").val('');
 		}	
 	        $("#inputId").keyup(setIdReset);
 	        
 		function setNnReset() {
 			$("#checkedNn").val('');
 		}	
 	        $("#inputNickname").keyup(setNnReset);
		
 		
 		// ##비밀번호 패턴 에러
 		$('#join').click(function() {
 			if($('#pwPatternError').val() != null) {
 				//비밀번호 패턴 에러가 있다면
 				console.log("#pwPatternError");
 				$('#pwPatternError').show();
 			} else if($('#pwNullError').val() != null) {
 				//비밀번호가 null 이면	
 				$('#pwPattern').hide();
 				$('#pwPatternError').show();
 			}
 			
 			
 		}); 
 			
    	// ##이메일 주소 선택 & 패턴식 추가
        $('#email-select1').change(function() {
            if ($('#email-select1').val() == 'directly') {
                $('#textEmail').attr('disabled', false);
                $('#textEmail').val('');
                $('#textEmail').focus();
                $('#textEmail').attr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
               
            } else if($('#email-select1').val() == 'disabled') {
            	$('#textEmail').val('');
            	$('#textEmail').removeAttr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
            } else {
                $('#textEmail').val($('#email-select1').val());
            	$('#textEmail').removeAttr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
            }
        });
        
        // ##이메일 값을 합쳐서 name="email"으로 보내기 
        function setEmailInput() {
        	var email = $("#emailFront").val() + "@" + $("#textEmail").val();  
        	$("#email-input").val(email);
        }
        
        $("#email-select1").change(setEmailInput);
        $("#emailFront").keyup(setEmailInput);
        $("#textEmail").keyup(setEmailInput);
        
  
 
        // ##작정 시 null Error hide
        // 아이디
        $("#inputId").keyup(function() {
        		$("#idNullError").hide();
				$("#idNull").hide();
        	});
        
        // 비밀번호
        $("#password").keyup(function() {
        		$("#pwNullError").hide();
        });
        
        // 비밀번호 확인
        $("#pwConfirm").keyup(function() {
        		$("#pwCfNullError").hide();
        });
        
        // 이름
        $("#name").keyup(function() {
        		$("#nameNull").hide();
        });
        
        // 닉네임
        $("#inputNickname").keyup(function() {
        		$("#nicknameNullError").hide();
				$("#nicknameNull").hide();
        });
        
	      
        // ##이메일 값이 null이 아니라면 id="emailError" hide
        function hideEmailError() {
        	if($("#emailFront").val() && $("#textEmail").val()) {
	        	$("#emailError").hide();
        	}
       	}
               
        $("#emailFront").keyup(hideEmailError);
        $("#textEmail").keyup(hideEmailError);
        $("#email-select1").change(hideEmailError);
       
       // ##주소 값이 변하면 주소를 입력해주세요 삭제.. 어떻게해ㅠㅠ
		function hideLocError() {
			if($("#sample3_postcode").val() || $("#sample3_address").val() ||
				$("#sample3_detailAddress").val() || $("#sample3_extraAddress").val()){
				$("#locNullError").hide();
			} 
		}
		
		$("#sample3_postcode").keyup(hideLocError);
		$("#sample3_address").keyup(hideLocError);
		$("#sample3_detailAddress").keyup(hideLocError);
		$("#sample3_extraAddress").keyup(hideLocError);


        $("#sample3_postcode").change(setLocInput);
        $("#sample3_address").change(setLocInput);
        $("#sample3_detailAddress").keyup(setLocInput);
        $("#sample3_extraAddress").change(setLocInput);      
    });
    
// ##주소 값을 합쳐서 name="loc"로 보내기
function setLocInput() {
	var loc = $("#sample3_postcode").val() + "@" + $("#sample3_address").val() + "@" +
	$("#sample3_detailAddress").val() + "@" + $("#sample3_extraAddress").val();
	$("#loc-input").val(loc);
}