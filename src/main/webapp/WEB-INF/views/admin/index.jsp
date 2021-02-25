<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="cu" tagdir="/WEB-INF/tags/admin"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.15.2/js/all.js" data-auto-replace-svg="nest"></script>
<link rel="stylesheet" type="text/css" href="root/resources/css/font.css">
<script>
$(document).ready(function() {
	$(".nav-link").click(function() {
		var link = $(this).attr("data-href");
		console.log(link);
		$("#iframe-link").attr("src", link);
	});

});

</script>
<style type="text/css">
span {
text-align: right;
}
</style>
</head>
<body>
	<cu:adminNav/>
<div class="container-fluid my-5">
   <div class="row">
      <div class="col-12 col-md-8 offset-md-2 table-responsive"> 

	<section>
 		<div class="mt-2" id="container_box"> 
		<iframe src="" id="iframe-link" width="100%" height="900px" 
		frameborder="0" framespacing="0" marginheight="0" marginwidth="0" vspace="0"></iframe>

		</div>
	</section>
      </div>
   </div>
</div>
</body>
</html>