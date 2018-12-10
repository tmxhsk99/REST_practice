console.log("Reply Module.......");

var replyService = (()=>{
	//리플 추가 
	var add=(reply,callback,error)=>{
		console.log("reply................")
		
			
		$.ajax({
			type : 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : (result , status , xhr)=>{
				if(callback){
					callback(result);
				}
			},
			error : (xhr,status, er )=>{
				if(error){
					error(er);
				}
			}
	})
	}
	//리플의 리스트
	var getList =(param,callback,error)=>{
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",
				data=>{
					if(callback){
						callback(data);
					}
				}).fail((xhr,status,err)=>{
			if (error) {
				error();
			}
		});
	}
	//댓글의 삭제
	var remove=(rno,callback,error)=>{
		$.ajax({
			type : 'delete',
			url : '/replies/'+rno,
			success : (deleteresult , status , xhr)=>{
				if(callback){
					callback(deleteresult);
				}
			},
			error : (xhr,status, er )=>{
				if(error){
					error(er);
				}
			}
		})
	} 
	//댓글의 수정
	var update =(reply,callback, error)=>{
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : 'put',
			url : '/replies/'+ reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : (result, status, xhr)=>{
				if(callback){
					callback(result);
				}
			},
			error : (xhr ,status, er)=>{
				if(error){
					error(er);
				}
			}
		})
	}
	//댓글 조회 처리 
	var get = (rno , callback, error)=>{
		$.get("/replies/" + rno + ".json",(result)=>{
			if(callback){
				callback(result);
			}
		}).fail((xhr, status,err)=>{
			if(error){
				error();
			}
		});
	}
	
	return {
	add : add,
	getList : getList,
	remove : remove,
	update : update,
	get : get
	};
})();

