package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	//리플 추가
	int insert(ReplyVO vo);
	//리플 조회 처리
	public ReplyVO read(Long bno);
	//삭제
	public int delete(Long bno);
	//수정 
	public int update (ReplyVO reply);
	//Criteria
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,@Param("bno") Long bno);

}
