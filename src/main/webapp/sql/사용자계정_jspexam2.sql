create sequence seq_board;

create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board
primary key (bno);

insert into tbl_board(bno,title,content,writer)
values (seq_board.nextval,'테스트 제목','테스트 내용','user00');

commit;
select * from tbl_board;
select * from tbl_board where bno > 0;
select seq_board.nextval from dual;
select * from tbl_board order by bno desc;--order by 를 사용
select /*+index_desc (tbl_board pk_board)*/* from tbl_board;--힌트를 사용한 정렬
insert into tbl_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from tbl_board);

--댓글 처리를 위한 테이블 생성과 처리 
create table tbl_reply(
	rno number(10,0),
	bno number(10,0) not null,
	reply varchar2(1000) not null,
	replyer varchar2 (50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate
	);
	
create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);

select * from tbl_board where rownum <10 order by bno desc