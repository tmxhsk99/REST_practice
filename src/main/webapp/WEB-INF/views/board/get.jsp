<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<script src="/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click",function(e){
			operForm.attr("action","/board/modify").submit();
		});
		
		$("button[data-oper='list']").on("click",function(e){
			operForm.attr("action","/board/list").submit();
		});
		
	});
</script>
<title>SB Admin 2 - Bootstrap Admin Theme</title>
</head>

<body>

	<%@include file="../includes/header.jsp"%>
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Read Page</div>
				<!-- /.panel heading -->
				<div class="panel-body">
					<div class="form-gruop">
						<label>Bno</label> <input class="form-control" name="bno"
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title"
							value="<c:out value='${board.title}'/>" readonly="readonly">
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea rows="3" class="form-control" rows="3" name="content"
							readonly="readonly"><c:out value="${board.content}" /></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer"
							value="<c:out value ='${board.writer}'/>" readonly="readonly">
					</div>
					<button data-oper='modify' class="btn btn-default">Modify</button>
					<button data-oper='list' class="btn btn-info">List</button>
					
					<form id="operForm" action="/board/modify"method="get">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
						<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
						<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
						<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
						<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
						
					</form>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>

	</div>
	<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<%@include file="../includes/footer.jsp"%>

</body>

</html>








