<%@ tag language="java" pageEncoding="UTF-8"%>


<div id="nav_restaurant" class="nav_body">
	<%--
	<c:if test="${status.count%2 == 1 }"><div class="row"></c:if>
		<div class="col-sm-6">
				
			<div class="card mb-3">
				<img src="${staticPath }/${res.filename}" class="card-img-top img-fluid cardimg mt-2"
					style="width: 250px;">
				<div class="card-body">
					<h5 class="card-title" style="font-weight: bold;">${res.rname }</h5>
					<p class="card-text">
						<input type="hidden" name="resno" value="${res.no }" id="resno" /><c:out value="${res.mname }"/> <br>
						<c:out value="${res.rloc }"/><br>
					</p>
					<p class="card-text">
						대표메뉴 : <c:out value="${res.menu }"/><br>
						<small class="text-muted"><u:pre value="${res.description }"/><br>
						전화 : <c:out value="${res.contact }"/></small><br>
					</p>
					<div class="d-flex justify-content-end align-items-center mb-1 likeDislike">
						<img data-resNo="${res.no }" id="like-img${status.count }" src="${root }/resources/img/like/like_empty2.png" width="25px" height="25px">
						<span>&nbsp; ${res.likecnt }&nbsp;</span>
						<img data-resNo="${res.no }" id="dislike-img${status.count }" src="${root }/resources/img/like/dislike_empty.png" width="25px" height="25px">
						<span>&nbsp;${res.dislikecnt }</span>
					</div>
				</div>
			</div>
	
		</div>
	<c:if test="${status.count%2 == 0 }"></div></c:if>
	 --%>
</div>