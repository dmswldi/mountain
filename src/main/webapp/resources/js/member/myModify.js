$(document).ready(function() {
		
		$('#emailPattern').hide();

		// ##패스워드 패턴 확인 멘트 - hide
		$("#pwPattern").hide();
		
		// ##닉네임 중복 확인 멘트 - hide
		$('#nicknameOk').hide();
		$('#nicknameDup').hide();
		$('#nicknameNull').hide();	
		
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
		
		// ##(닉네임 수정 후) 중복 검사를 해주세요.
		function nnKeyup(){
			$("#nicknameDupCheck").removeAttr("disabled"); // 버튼 비활성화 해제
			$("#checkedNn").val('');
			$("#modify").click(function(e) {
				e.preventDefault();
				if($("#checkedNn").val() == ''){
					alert("닉네임 중복 확인을 해주세요.");
					return false;
				} else {
					$("#modifyForm1").submit();
				}
			});
		}
		$("#inputNickname").keyup(nnKeyup);
		
		
    	// ##이메일 주소 선택
        $('#email-select1').change(function() {
            if ($('#email-select1').val() == 'directly') {
                $('#textEmail').attr('disabled', false);
                $('#textEmail').val('');
                $('#textEmail').focus();
                $('#textEmail').attr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
                $('#emailPattern').show();
            } else if($('#email-select1').val() == 'disabled') {
            	$('#textEmail').val('');
            	$('#textEmail').removeAttr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
                $('#emailPattern').hide();
            } else {
                $('#textEmail').val($('#email-select1').val());
            	$('#textEmail').removeAttr('pattern','[a-z0-9.-]+\.[a-z]{2,}$');
                $('#emailPattern').hide();
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

        // ##비밀번호 값을 수정하면 pattern 멘트
        function showPwPattern() {
        	$("#pwPattern").show();
        }
        $("#staticPw").keyup(showPwPattern);
        
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
  