
drop table BOOK_LENDING;
drop table BOOK_COPIES;
drop table BOOK_AUTHORS;
drop table BOOK;
drop table LIBRARY_BRANCH;
drop table PUBLISHER;


create table PUBLISHER
(
	Name varchar(15),
	Address varchar(15),
	Phone varchar(10),
	Primary key (Name)
);

create table LIBRARY_BRANCH
(
	Branch_id varchar(4),
	Branch_name varchar(15),
	Address varchar(15),
	Primary key (Branch_id)
);

create table BOOK
(
	Book_id varchar(4),
	Title varchar(10),
	Publisher_name varchar(10),
	Pub_year int,
	Primary key (Book_id),
	Foreign key (Publisher_name) references PUBLISHER (Name) on delete cascade
);

create table BOOK_AUTHORS
(
	Book_id varchar(4),
	Author_name varchar(10),
	Primary key (Book_id),
	Foreign key (Book_id) references BOOK (Book_id) on delete cascade
);

create table BOOK_COPIES
(
	Book_id varchar(4),
	Branch_id varchar(4),
	No_of_Copies int,
	Primary key (Book_id,Branch_id),
	Foreign key (Book_id) references BOOK (Book_id) on delete cascade,
	Foreign key (Branch_id) references LIBRARY_BRANCH (Branch_id) on delete cascade	
);

create table BOOK_LENDING
(
	Book_id varchar(4),
	Branch_id varchar(4),
	Card_no int,
	Date_out date,
	Due_date date,
	Primary key (Book_id,Branch_id,Card_no),
	Foreign key (Book_id) references BOOK (Book_id) on delete cascade,
	Foreign key (Branch_id) references LIBRARY_BRANCH (Branch_id) on delete cascade
);


desc PUBLISHER;
desc LIBRARY_BRANCH;
desc BOOK;
desc BOOK_AUTHORS;
desc BOOK_COPIES;
desc BOOK_LENDING;


insert into PUBLISHER values('Apeksha','Mangalore','7022405943');
insert into PUBLISHER values('Ayan','Bangalore','8765456788');
insert into PUBLISHER values('Diya','Chennai','1111122222');
insert into PUBLISHER values('Karthik','london','2323232323');
insert into PUBLISHER values('Karan','Pakistan','7878787878');

insert into LIBRARY_BRANCH values('b1','branch1','Mangalore');
insert into LIBRARY_BRANCH values('b2','branch2','Bangalore');
insert into LIBRARY_BRANCH values('b3','branch3','Chennai');

insert into BOOK values('bo1','ATC','Apeksha',2001);
insert into BOOK values('bo2','DBMS','Ayan',2002);
insert into BOOK values('bo3','ADP','Diya',2003);
insert into BOOK values('bo4','CN','Karthik',2004);
insert into BOOK values('bo5','ME','Karan',2005);

insert into BOOK_AUTHORS values('bo1','R.T');
insert into BOOK_AUTHORS values('bo2','notR.T');
insert into BOOK_AUTHORS values('bo3','lilR.T');
insert into BOOK_AUTHORS values('bo4','R.T?');
insert into BOOK_AUTHORS values('bo5','R.T!');

insert into BOOK_COPIES values('bo1','b1',5);
insert into BOOK_COPIES values('bo2','b2',6);
insert into BOOK_COPIES values('bo3','b3',7);
insert into BOOK_COPIES values('bo4','b1',4);
insert into BOOK_COPIES values('bo5','b2',9);
insert into BOOK_COPIES values('bo2','b3',8);
insert into BOOK_COPIES values('bo4','b2',10);
insert into BOOK_COPIES values('bo1','b2',2);

insert into BOOK_LENDING values('bo1','b1',1,'02-jan-17','10-jan-17');
insert into BOOK_LENDING values('bo2','b2',1,'11-jan-17','11-mar-17');
insert into BOOK_LENDING values('bo3','b3',1,'21-feb-17','21-apr-17');
insert into BOOK_LENDING values('bo4','b1',1,'15-mar-17','15-jul-17');
insert into BOOK_LENDING values('bo5','b2',1,'12-apr-17','12-may-17');
insert into BOOK_LENDING values('bo3','b3',2,'21-feb-17','21-apr-17');


select * from PUBLISHER;
select * from LIBRARY_BRANCH;
select * from BOOK;
select * from BOOK_AUTHORS;
select * from BOOK_COPIES;
select * from BOOK_LENDING;


--Query1
select a.book_id, a.title, a.publisher_name, b.author_name, c.no_of_copies, d.branch_id
from BOOK a, BOOK_AUTHORS b, BOOK_COPIES c, LIBRARY_BRANCH d 
where a.book_id = b.book_id
	and	c.book_id = a.book_id
	and	c.branch_id = d.branch_id;


--Query2
select card_no 
from book_lending
where date_out between '01-jan-2017' and '01-jul-2017'
group by card_no
having count (*) > 3;


--Query3
delete from book where book_id='bo5';


--Query4
create view V_Pub as 
select pub_year
from book;

select * from v_pub;


--Query5
create view v_books as 
select a.book_id, a.title, c.branch_id, b.no_of_copies 
from book a, book_copies b, library_branch c
where a.book_id=b.book_id
	and	b.branch_id=c.branch_id;

select * from v_books;



