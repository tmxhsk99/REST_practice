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
values (seq_board.nextval,'�׽�Ʈ ����','�׽�Ʈ ����','user00');

commit;
select * from tbl_board;
select * from tbl_board where bno > 0;
select seq_board.nextval from dual;
select * from tbl_board order by bno desc;--order by �� ���
select /*+index_desc (tbl_board pk_board)*/* from tbl_board;--��Ʈ�� ����� ����
insert into tbl_board(bno,title,content,writer)
(select seq_board.nextval,title,content,writer from tbl_board);

--��� ó���� ���� ���̺� ������ ó�� 
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

select * from tbl_board where rownum <10 order by bno desc;

select * from tbl_reply order by rno desc;

select /*+INDEX(tbl_reply idx_reply) */
rownum rn, bno, rno , reply, replyer, replyDate , updatedate
from tbl_reply
where bno = 16899
and rno > 0;

--������ ����¡ó���� ���� ���� ���
SELECT rno, bno, reply, replyer, replydate, updatedate 
FROM 
( SELECT /* + INDEX(tbl_ reply idx_reply) */
  ROWNUM rn,bno, rno, reply, replyer, replyDate, updatedate
  FROM    tbl_reply
  WHERE bno = 16899
  and rno >0
  and rownum <=20
) where rn > 10 ;
--������ ����¡ ó���� ���� �ش� �Խù� ���� ��ü��  
SELECT count(rno) from tbl_reply where bno = 16899;

create table tbl_sample1( col1 varchar2(500));
create table tbl_sample2( col2 varchar2(50));

select * from tbl_sample1 ;
select * from tbl_sample2 ;

delete tbl_sample1;
delete tbl_sample2;
commit;

--tbl_board�� replycnt�� �߰� 
alter table tbl_board add (replycnt number default 0);
--������ �ִ� ���ð����� update 
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);


--첨부파일 추가를 위한 테이블 추가와 관계 설정
create table tbl_attach(
  uuid varchar2(100) not null ,
  uploadPath varchar2(200) not null,
  fileName varchar2(100) not null,
  filetype char(1) default 'I',
  bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid);

alter table tbl_attach add constraint fk_board_attach foreign key (bno)
references tbl_board(bno);

commit;


