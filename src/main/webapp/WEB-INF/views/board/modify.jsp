<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>
<style>
.uploadResult {
	width: 100%;
	background-color: gray;
}

.uploadResult ul {
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li {
	list-style: none;
	padding: 10px;
	align-content: center;
	text-align: center;
}

.uploadResult ul li img {
	width: 100px;
}

.uploadResult ul li span {
	color: white;
}

.bigPictureWrapper {
	position: absolute;
	display: none;
	justify-content: center;
	align-items: center;
	top: 0%;
	width: 100%;
	height: 100%;
	background-color: gray;
	z-index: 100;
	background: rgba(255, 255, 255, 0.5);
}

.bigPicture {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
}

.bigPicture img {
	width: 600px;
}
</style>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Modify</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/board/modify" method="post">

					<input type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum }"/>'> <input
						type='hidden' name='amount'
						value='<c:out value="${cri.amount }"/>'> <input
						type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
					<input type='hidden' name='keyword'
						value='<c:out value="${cri.keyword }"/>'>


					<div class="form-group">
						<label>Bno</label> <input class="form-control" name='bno'
							value='<c:out value="${board.bno}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>Title</label> <input class="form-control" name='title'
							value='<c:out value="${board.title }"/>'>
					</div>

					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" rows="3" name='content'><c:out
								value="${board.content}" /></textarea>
					</div>

					<div class="form-group">
						<label>Writer</label> <input class="form-control" name='writer'
							value='<c:out value="${board.writer}"/>' readonly="readonly">
					</div>

					<div class="form-group">
						<label>RegDate</label> <input class="form-control" name='regDate'
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'
							readonly="readonly">
					</div>

					<div class="form-group">
						<label>Update Date</label> <input class="form-control"
							name='updateDate'
							value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updateDate}" />'
							readonly="readonly">
					</div>



					<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
					<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
					<button type="submit" data-oper='list' class="btn btn-info">List</button>
				</form>


			</div>
			<!--  end panel-body -->
			<!-- 첨부파일 -->
			<!-- 첨부파일이 보여지는 부분 -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel panel-default">
							<div class="panel-heading">Files</div>
							<!-- panel heading -->
							<div class="panel-body">
							 <div class="form-group uploadDiv">
							 	<input type="file" name ="uploadFile" multiple="multiple">
							 </div>
								<div class="uploadResult">
									<ul>
									</ul>
								</div>
							</div>
							<!-- end panel-body -->
						</div>
						<!-- end panel-body -->
					</div>
					<!-- end panel -->
				</div>
				<!-- /.row -->
			</div>
			<!-- 첨부파일 end-->
		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");

		$('button').on("click", function(e) {

			e.preventDefault();
			var operation = $(this).data("oper");
			alert(operation);
			console.log(operation);

			if (operation === 'remove') {
				formObj.attr("action", "/board/remove");

			} else if (operation === 'list') {
				//move to list 

				formObj.attr("action", "/board/list").attr("method", "get");

				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='amount']").clone();
				var typeTag = $("input[name='amount']").clone();

				formObj.empty();
				//formObj.(amountTag);
				//formObj.(pageNumTag);
			}else if(operation === 'modify'){
				console.log("submit clicked");
				var str = "";
				$(".uploadResult ul li ").each(function(i,obj){
					var jobj = $(obj);
					console.dir(jobj);
/* 					alert(jobj.data("fileName"));
					alert(jobj.data("uuid"));
					alert(jobj.data("path"));
					alert(jobj.data("type"));
 */
				str += "<input type='hidden' name ='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>"; 
				str += "<input type='hidden' name ='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>"; 
				str += "<input type='hidden' name ='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>"; 
				str += "<input type='hidden' name ='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>"; 
				});
				formObj.append(str).submit();
			}

			formObj.submit();
			
			//파일 업로드 관련
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			var maxSize = 5242880; //5MB
			
			
			function checkExtension(fileName, fileSize){
				
				if(fileSize >=maxSize){
					alert("파일 사이즈 초과");
					return false;
				}
				if(regex.test(fileName)){
					alert("해당 종류의 파일은 업로드 할수가 없습니다.");
					return false;
				}
				return true;
			}
			  $("input[type='file']").change(function(e){

				    var formData = new FormData();
				    
				    var inputFile = $("input[name='uploadFile']");
				    
				    var files = inputFile[0].files;
				    
				    for(var i = 0; i < files.length; i++){

				      if(!checkExtension(files[i].name, files[i].size) ){
				        return false;
				      }
				      formData.append("uploadFile", files[i]);
				      
				    }
				    
				    $.ajax({
				      url: '/uploadAjaxAction',
				      processData: false, 
				      contentType: false,data: 
				      formData,type: 'POST',
				      dataType:'json',
				        success: function(result){
				          console.log(result); 
						  showUploadResult(result); //업로드 결과 처리 함수 

				      }
				    }); //$.ajax
				    
				 }); 
			  function showUploadResult(uploadResultArr){
				  //업로드가 텅비면  그냥리턴 
				  if(!uploadResultArr || uploadResultArr.length == 0){return;}
				  
				  var uploadUL =$(".uploadResult ul");
				  
				  var str ="";
				  
				  $(uploadResultArr).each(function(i,obj){
					 //image type
					 if(obj.image){
						 //이미지일경우의 경로를 작성 
						 var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid + "_"+obj.fileName);
						 
						 str += "<li data-path= '"+obj.uploadPath+"'";
						 str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
						 str += "><div>";
						 str += "<span> "+ obj.fileName+"</span>";
						 str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						 str += "<img src= '/display?fileName="+ fileCallPath +"'>";
						 str += "</div>";
						 str +"</li>";
					 }else{
						 var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid + "_"+obj.fileName);
						 var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
						 
						 str += "<li data-path= '"+obj.uploadPath+"'";
						 str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'";
						 str += "><div>";
						 str += "<span> " + obj.fileName + "</span>";
						 str += "<button type='button'data-file=\'"+fileCallPath+"\'data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						 str += "<img src= '/resources/img/attach.png'></a>";
						 str += "</div>";
						 str += "</li>";
					 }
					
				  });
				  uploadUL.append(str);
			  }
			
		});

		
		
		//게시물의 첨부파일 정보리스트 불러오기 
		(function(){
			var bno = '<c:out value="${board.bno}"/>';
			$.getJSON("/board/getAttachList",{bno:bno}, function(arr){
				console.log(arr);
				var str ="";
				$(arr).each(function(i,attach){
					//image type
					if(attach.fileType){
						/* 파일타입이 이미지인 경우 */
						var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
						 str += "<li data-path= '"+attach.uploadPath+"'";
						 str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'";
						 str += "><div>";
						 str += "<span> "+ attach.fileName+"</span>";
						 str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='image' "
						 str += "class = 'btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
						 str += "<img src= '/display?fileName="+ fileCallPath +"'>";
						 str += "</div>";
						 str +"</li>";
					}else{

						 str += "<li data-path= '"+attach.uploadPath+"'";
						 str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'";
						 str += "><div>";
						 str += "<span> " + attach.fileName + "</span>";
						 str += "<button type='button' data-file=\'"+fileCallPath+"\'data-type='file' "
						 str += "class = 'btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
						 str += "<img src= '/resources/img/attach.png'></a>";
						 str += "</div>";
						 str += "</li>";
					}
				});
				$(".uploadResult ul").html(str);
			});//endgetjson
			
		})();//end function
		
		
	});
	$(".uploadResult").on("click","button",function(e){
		console.log("delete file");
		if(confirm("첨부파일을 삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}	
	});
	

	
	
	
</script>





<%@include file="../includes/footer.jsp"%>
