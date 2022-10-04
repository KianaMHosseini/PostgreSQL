--PostgreSQL Maestro

--SQL Editor queries 


--Query &1

create table librarymember(
 mid numeric unique Primary Key,
 code numeric unique,
 Lname varchar(20),
 Lfamily varchar(20)
 )
 --Query &2

create table address(
  plate int primary key,
  street varchar(20),
  city varchar(20),
  Acode numeric,
  foreign key (Acode) references librarymember(code)
  
  )
  --Query &3

create table book(
   bid int unique,
   stoke int,
   edition int,
   bname varchar(20) unique,
   btype varchar(20)
   )--Query &4

create table borrow(
  bdate varchar(20),
  bookid int,
  mid numeric,
  borrownum int,
  foreign key (bookid) references book(bid),
  foreign key (mid) references librarymember(mid)
  )--Query &5

create table return(
  rdate varchar(20),
  bookid int,
  mid numeric,
  foreign key (bookid) references book(bid),
  foreign key (mid) references librarymember(mid)
  )--Query &6

create table authorname(
  bookname varchar(20),
  AuthorName varchar(20),
  foreign key (bookname) references book(bname)
  )--Query &7

insert into book (bid,stoke,edition,bname,btype)values(193,5,7,'kouri','novel'),
(224,3,7,'binavayan','novel'),(331,1,6,'barfak','romance'),
(900,3,4,'deracula','horror'),(678,4,1,'rebecca','romance')

select * from book--Query &8

insert into librarymember (mid,code,Lname,Lfamily)values
(22450233,2345246735,'raha','zakeri'),(22453781,7865309981,'maryam','ehsani'),
(22889734,2976651908,'ahmad','hosseini'),(22979602,9676237781,'mehdi','edalati'),
(22674534,3356869278,'arezo','hasani')

select * from librarymember--Query &9

/*insert into address (plate,street,city,Acode) values (5,'velayat','tehran',2345246735),
(4,'vatani','tehran',7865309981),(7,'nour','tabriz',2976651908),
(11,'sahel','shiraz',9676237781),(29,'navabi','tabriz',3356869278)*/

select * from address
--Query &10

insert into borrow (bdate,bookid,mid,borrownum) values ('azar',193,22450233,2),
('mordad',224,22453781,1),('azar',331,22889734,0),('tir',900,22979602,2),
('mordad',678,22674534,3)

select * from borrow--Query &11

insert into return (rdate,bookid,mid) values ('bahman',193,22450233),
('shahrivar',224,22453781),('azar',331,22889734),('azar',900,22979602),
('mehr',678,22674534)


select * from return



--Query &12

insert into authorname(bookname,Authorname)values('kouri','jose'),
('binavayan','victor'),('barfak','don'),('deracula','beram'),('rebecca','dafne')

select * from authorname--Query &13

select bname,stoke from book

select * from return where rdate like 'a%'

select count(*)from librarymember where Lfamily like 'e%'

/*author of books and its edition
select Authorname,edition from authorname join book on bookname=bname*/

/*author name,book's type and return date
select Authorname,btype,rdate from authorname join book on bookname=bname 
join return on bid=bookid*/

/*name of books have not returned in azar
select bname from book except select bname from book join return on bookid=bid 
where rdate = 'azar'*/

/*with SUBQUERY
select bname from book 
where bid not in(select bookid from return where rdate='azar')*/

/*name of books returned but not in azar by (ANY SUBQUERY)
select bname from book 
where bid =any(select bookid from return where rdate!='azar')*/

/*name of books borrowed in mordad with EXISTS
select bname from book
where exists (select bookid from borrow where bdate='mordad')*/

/*name and last name of person borrowed book and return date with FROM CLAUSE
select Lname,Lfamily,rdate from
(select Lname,Lfamily,mid from librarymember)as Name
join
(select rdate,mid from return)as return
on name.mid=return.mid*/



--Query &14

/*create view booktb as
select * from book where bname like 'b%'

insert into book values (443,2,1,'badban','science')*/

/* by use of view say group of book's name that start by b
select bname from booktb where bname like 'b%'*/

/*function that take bookid and give stoke and edition and name
create function booktb1 (newbid int) returns table (stoke int,bname varchar(20),
edition int) as $$
select bid from book where bid=newbid
$$language sql;

select * from booktbl(193)*/


create or replace function numnew(a int ) returns numeric as $$
declare 
counter int :=0;
num numeric:=1;
begin 

while (counter<5) loop 
      num:=num*a;
      counter:=counter+1;
end loop;
return num;
end;$$ language plpgsql;

--Query &15

/*select numnew (5)*/--Query &16

 select count(*),bookid from borrow where bdate='azar' or bdate='aban' or bdate='bahman'
group by bookid
