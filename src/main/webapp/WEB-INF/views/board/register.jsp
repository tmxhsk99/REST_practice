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
				
				<div class="panel-body">
				<form role="form" action="/board/register" method="post">
					<div class="form-gruop">
						<label>Title</label>
						<input class="form-control" name="title">
					</div>
					
					<div class="form-group">
						<label>Text area</label>
						<textarea rows="3" class="form-control" rows="3" name="content"></textarea>
					</div>
					
					<div class="form-group">
						<label>Writer</label><input class="form-control" name="writer">
					</div>
					<button type="submit" class="btn btn-default">Submit Button</button>
					<button type="reset" class="btn btn-default">Reset Button</button>
				
				</form>
				
				</div>						
				



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
