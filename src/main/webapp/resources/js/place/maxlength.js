	/* 글자수 제한 */
	function maxLengthCheck(id, title, maxLength){
	     console.log(id);
	     var obj = $("#"+id);
	     if(maxLength == null) {
	         maxLength = obj.attr("maxLength") != null ? obj.attr("maxLength") : 1000;
	     }
	     
	     if(Number(byteCheck(obj)) > Number(maxLength)) {
	       	swal(title + "에 입력가능 문자수를 초과하였습니다.", "(영문, 숫자, 일반 특수문자 : " + maxLength  +"\n 한글, 한자, 기타 특수문자 : " + parseInt(maxLength/2, 10) + ")", "warning");
	         obj.focus();
	         return false;
	     } else {
	         return true;
	    }
	}
	 
	/*
	 * 바이트수 반환  
	 */
	function byteCheck(el){
	    var codeByte = 0;
	    for (var idx = 0; idx < el.val().length; idx++) {
	        var oneChar = escape(el.val().charAt(idx));
	        if ( oneChar.length == 1 ) {
	            codeByte ++;
	        } else if (oneChar.indexOf("%u") != -1) {
	            codeByte += 2;
	        } else if (oneChar.indexOf("%") != -1) {
	            codeByte ++;
	        }
	    }
	    return codeByte;
	}