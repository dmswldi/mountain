$(function(){
	if(result == 'notUnique'){
		swal({
			title: "Not available",
			text: "이미 존재하는 산 이름입니다.",
			icon: "warning",
			button: "close"
		});
	}
	
	if(result == 'wrongPattern'){
		swal({
			title: "Not available",
			text: "산 이름을 정확히 작성해주세요.",
			icon: "warning",
			button: "close"
		});
	}

	$('#onlyNum').hide();
	$('#height').focusout(function() {
		var height = $('#height').val();
		var reg = /^[0-9]+$/;
		
		if( height.match(reg) ){
			$('#onlyNum').hide();
		} else {
			$('#onlyNum').show();
		}
	});
	
	
		
	
});