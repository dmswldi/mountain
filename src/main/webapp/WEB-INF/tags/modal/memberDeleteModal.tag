<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<div class="modal fade" id="memberDeleteModal" tabindex="-1" aria-labelledby="memberDeleteModal" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="ModalTitle">탈퇴하시겠습니까??</h5>
	        <button id="memberDeleteCancel1" type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <label for="pwConfirm" class="col-form-label">비밀번호 확인</label>
	            <input type="password" class="form-control" id="pwConfirm">
	          		<small class="form-text" style="color: tomato" id="pwError">
	      				비밀번호가 일치하지 않습니다.
	      			</small>
	      			<small class="form-text" style="color: tomato" id="pwNull">
	      				비밀번호를 입력해주세요.
	      			</small>
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" id="memberDeleteCancel2">취소</button>        
	        <button type="button" class="btn btn-success" id="memberDelete" data-userId="${authUser.id }">탈퇴</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="modal fade" id="memberDeleteSuccessModal" tabindex="-1" >
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="ModalTitle">탈퇴되었습니다.</h5>
	      </div>
	      <div class="modal-body">
			<span class="form-text">
	      		정상적으로 탈퇴되었습니다.
	      	</span>
	      </div>
	      <div class="modal-footer">
	        <a href="${root }/index.jsp">
	        	<button type="button" class="btn btn-secondary">닫기</button>
	        </a>
	      </div>
	    </div>
	  </div>
	</div>
