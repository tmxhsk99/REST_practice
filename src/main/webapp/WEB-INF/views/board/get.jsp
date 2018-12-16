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
<script src="/resources/js/reply.js/?c"></script>

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

					<form id="operForm" action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno"
							value='<c:out value="${board.bno}"/>'> <input
							type="hidden" name="pageNum"
							value='<c:out value="${cri.pageNum }"/>'> <input
							type="hidden" name="amount"
							value='<c:out value="${cri.amount }"/>'> <input
							type="hidden" name="keyword"
							value='<c:out value="${cri.keyword }"/>'> <input
							type="hidden" name="type" value='<c:out value="${cri.type }"/>'>

					</form>
				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
			<div class='row'>
				<div class="col-lg-12">
					<!-- /.panel -->
					<div class="panel panel-default">
						<!-- <div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i> Reply
						</div> -->
						<!-- /.panel-heading -->
						<div class="panel-heading">
							<i class="fa fa-comments fa-fw"></i>Reply
							<button id='addReplyBtn'
								class='btn btn-primary btn-xs pull-right'>New Reply</button>
						</div>
						<div class="panel-body">
							<ul class="chat">
								<!-- 리플이 보여지는는 부분 -->		
							</ul>
						</div>
						<!--/.panel .chat-panel 추가  -->
						<div class="panel-footer">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.col-lg-12 -->
		<!-- Modal -->

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
					</div>
					<div class="modal-body"><div class="form-group">
							<label>Reply</label> <input class="form-control" name="reply"
								value="New Reply!!!!!">
						</div>

						<div class="form-group">
							<label>Replyer</label> <input class="form-control" name="replyer"
								value="replyer">
						</div>

						<div class="form-group">
							<label>Reply Date</label> <input class="form-control"
								name="replyDate" value="">
						</div>
					</div>
					<div class="modal-footer">
						<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
						<button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
						<button id="modalRegisterBtn" type="button"
							class="btn btn-primary">Register</button>
						<button id="modalCloseBtn" type="button" class="btn btn-default">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>


		<!-- /#page-wrapper -->
	</div>
	<!-- /#wrapper -->
	<%@include file="../includes/footer.jsp"%>

	<script type="text/javascript">
	

	$(document).ready(function() {
		console.log(replyService);
		var bnoValue = '<c:out value="${board.bno}"/>';
		var replyUL = $(".chat"); 
		
		showList(1);
		//리스트 갱신 함수 여러번 사용하기때문에 arrowfunction을 사용하지 않ㄴ다. 
	 	 function showList(page){
			replyService.getList({bno:bnoValue,page: page || 1},function(replyCnt,list){
				
				console.log("replyCnt: "+ replyCnt);
				console.log("list: "+ list);
				console.log(list);
				
				if(page ==-1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str="";
				
				if(list == null || list.length == 0){
					return;
				}
				
				for(var i = 0 , len = list.length || 0 ; i<len; i++){
					str += "<li class='left clearfix' data-rno = '"+list[i].rno+"'>";
					str += " <div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str += " <small class= 'pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+ "</small></div>";
					str += " <p>"+list[i].reply+"</p></div></li>";
				}
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});//end func
		
		};//end showList 
		
		//<div class='panel-footer'> 에 댓글 페이지 번호를 출력하는 로직은 show ReplyPage()는 아래와 같다 
		var pageNum = 1;
		var replyPageFooter = $(".panel-footer");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum / 10.0)*10;
			var startNum = endNum -9 ;
			
			var prev = startNum != 1;
			var next = false;
			
			if (endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			if (endNum * 10 < replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			var str ="<ul class ='pagination pull-right'>";
			
			if(prev){
				str+= "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previos</a></li>";
			}
			
			for(var i = startNum ; i<endNum ; i++){
				var active = pageNum == i? "active" : "";
				str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next){
				str += "<li class ='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
			}
			str += "</ul></div>";
			
			console.log(str);
			replyPageFooter.html(str);
		}
		//페이지 번호를 클릭했을때 새로운 댓글을 가져오도록 하는 부분
		replyPageFooter.on("click","li a",function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum :" +targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		})
		//modal
		var modal = $(".modal");
		
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate= modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#addReplyBtn").on("click",(e) => {
			
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		//새로운 댓글 추가처리
		modalRegisterBtn.on("click",(e)=>{
			//등록 버튼을 클릭하면 내용을 JSON형식으로 변환
			var reply ={
					reply: modalInputReply.val(),
					replyer:modalInputReplyer.val(),
					bno: bnoValue
			};
			//모듈 add사용 
			replyService.add(reply, (result) => {
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				//showList(1);
				showList(-1);
			});
			
		})
		//댓글의 클릭 이벤트 처리 
		$(".chat").on("click","li",function(e){
			
			var rno = $(this).data("rno");
			
			replyService.get(rno,(reply) => {
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly","readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		//댓글 수정 이벤트 
		modalModBtn.on("click", (e)=>{
			//json 형식으로  rno와 reply내용을 만듬
			var reply = {rno : modal.data("rno"), reply: modalInputReply.val()};
			//수정
			replyService.update(reply, (result)=>{
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			})
		})
		//댓글 삭제 이벤트 
		modalRemoveBtn.on("click", (e)=>{
			//리플 번호를 가져옴
			var rno = modal.data("rno");
			//삭제
			replyService.remove(rno, (result)=>{
				
				alert(result);
				modal.modal("hide");
				showList(pageNum);
			})
		})
		
		/*페이지를 전환  */
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", "/board/modify").submit();
		});

		$("button[data-oper='list']").on("click", function(e) {
			operForm.attr("action", "/board/list").submit();
		});
		
	});
</script>
</body>

</html>








