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
						//callback(data); 댓글의 목록만 가져오는경우
						callback(data.replyCnt,data.list); //댓글의 숫자와 목록을 가져오는경우
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
	//displyTime
	var displayTime = (timeValue) => {
		var today = new Date();//오늘 날짜
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str ="";
		if(get < (1000 * 60 * 60 * 24 )){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ":" , (mi > 9 ? '' : '0') + mi ,
					":",(ss > 9 ? '' : '0')+ss].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1 ; //getMonth() is zero-based
			var dd = dateObj.getDate();
			
			return [yy, '/' , (mm > 9 ? '' : '0') + mm, '/',(dd >9 ?  '' : '0')+ dd].join('');
		}
		
	};
	
	return {
	add : add,
	getList : getList,
	remove : remove,
	update : update,
	get : get,
	displayTime : displayTime
	};
})();

