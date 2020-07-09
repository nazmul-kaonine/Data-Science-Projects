-- create OMDB --
-----------------
-- drop tables --
    drop TABLE albums force;
/ 
drop type disk_type force;
/ 
drop type mp3_type force;
/
drop type album_type force;
/
drop type artist_array_type force;
/
drop type artist_type force;
/
drop type review_table_type force;
/
drop type review_type force;
/
-- create types --
create or replace type artist_type as object 
(artistName 	varchar(50), 
 artistRole 	varchar(25))
/ 
create type artist_array_type  
as varray(5) of artist_type
/ 
create or replace type review_type as object 
(reviewerName 	varchar(25), 
 reviewDate   	date,
 reviewText   	varchar(250), 
 reviewScore  	number)
/
create or replace type review_table_type as table of review_type
/
create or replace type album_type as object 
(albumTitle 		varchar(50),
 albumPlaytime 		number(3), -- minutes
 albumReleaseDate 	date, 
 albumGenre 		varchar(15),
 albumPrice 		number(9,2),
 albumTracks		number(2),
 albumArtists		artist_array_type,
 albumReviews 		review_table_type,
member function discountPrice return number,
member function containsText (pString1 varchar2, pString2 varchar2) return integer)
not instantiable not final 
/
create or replace type disk_type under album_type 
( mediaType 		varchar(10),
 diskNum			number(2), -- number of disks
 diskUsedPrice 		number(9,2),
 diskDeliveryCost 	number(9,2), 
overriding member function discountPrice return number)
/
create or replace type mp3_type under album_type
(downloadSize 	number, -- size in MB
 overriding member function discountPrice return number)
/
-- create tables --
create table albums of album_type 
object id system generated
nested table albumReviews store as store_reviews 
/ 


insert into albums
values (disk_type('The Essential Bob Dylan',99,'8-JUL-2016','Pop',37.00,32,
artist_array_type(artist_type('Bob Dylan','Composer'),artist_type('Bob Dylan','Vocals')),
review_table_type(review_type('Shawn','24-JUL-2018','Wife loved it!',5),review_type('Reuben','2-AUG-2019','Great compilation of some of his most known songs',5)),
'Vinyl', 2, null, 11.00));
/

insert into albums
values(disk_type('Sketches of Spain',45,'08-MAR-2011','Jazz',14.99,6,
artist_array_type(
artist_type('Miles Davis','Composer'),
artist_type('Miles Davis','Musician')
),
review_table_type(
review_type('Frederick','16-SEP-2016','Recommend listening while viewing a sunset.',5),
review_type('Juliet','12-MAR-2018','Early days of The Great Miles--no lover of jazz should be without this album.',5)
),
'Vinyl',1,16.29,7.00
));
/
--3
insert into albums
values(disk_type('Bob Dylans Greatest Hits',45,'31-JAN-2017','Pop Rock',29.87,10,
artist_array_type(
artist_type('Bob Dylan','Composer'),
artist_type('Bob Dylan','Vocals')
),
review_table_type(
review_type('Kandy','16-MAR-2015','Early Dylan in all his glory!',5),
review_type('Stewart','18-FEB-2013','Captures Bob Dylan transformation from a folk song Composer to a rock legend',4)
),
'Vinyl',1,null,11.0
));
/
--4
insert into albums
values(disk_type('Harvest (2009 Remaster)',44,'21-JUN-2009','Rock Country',28.50,10,
artist_array_type(
artist_type('Neil Young','Composer'),
artist_type('Neil Young','Vocals')
),
review_table_type(
review_type('John','18-FEB-2019','I absolutely LOVE this CD!',5),
review_type('Stewart','18-FEB-2013','Sounds good in vinyl!',5)
),
'Vinyl',1,14.99,11.0
));


/
insert into albums
values (disk_type('Kind Of Blue (Legacy Edition)',155,'20-JAN-2009','Jazz',19.99,21,
artist_array_type(artist_type('Miles Davis','Composer'),artist_type('Miles Davis','Musician')),
review_table_type(review_type('Laurence','10-SEP-2014','Very very special recording.','5')),
'Vinyl',3,16.99,10.00));
/

insert into albums
values (disk_type('Harvest (2009 Remaster)',44,'21-JUN-2009','Rock Country',10.50,10,
artist_array_type(artist_type('Neil Young','Composer'),artist_type('Neil Young','Vocals')),
review_table_type(review_type('John','18-FEB-2019','I absolutely LOVE this CD!',5),review_type('Anthony','16-AUG-2019','Neil Youngs signature album',4)),
'Audio CD',1,4.99,11.00));

/

insert into albums
values (disk_type('The Essential Bob Dylan',99,'8-JUL-2016','Pop',26.17,32,
artist_array_type(artist_type('Bob Dylan','Composer'),artist_type('Bob Dylan','Vocals')),
review_table_type(review_type('Christopher','24-JUN-2016','	This is a terrific album.',	5),review_type('Cauley','2-AUG-2015','There can only be one Bob Dylan. God blessed him with the gift of verse.',5)),
'Audio CD',2,null,7.00));

/

insert into albums
values (disk_type('Bob Dylans Greatest Hits',50,'1-JUN-1999','Pop Rock',20.81,10,
artist_array_type(artist_type('Bob Dylan','Composer'),artist_type('Bob Dylan','Vocals')),
review_table_type(review_type('Kandy','16-MAR-2015','Early Dylan in all his glory.',5),review_type('Stewart','18-FEB-2013','Captures Bob Dylan transformation from a folk song composer to a rock legend.',4)),
'Audio CD',1,null,7.00));
/

insert into albums
values (disk_type('Kind Of Blue (Legacy Edition)',155,'20-JAN-2009','Jazz',19.99,21,
artist_array_type(artist_type('Miles Davis','Composer'),artist_type('Miles Davis','Musician')),
review_table_type(review_type('Amy','17-APR-2018','Poor quality sound compared to the vinyl record.',2)),
'Audio CD',3,16.99,10.00 ));


/

insert into albums
values (disk_type('Sketches of Spain',45,'20-JAN-2009','Jazz',3.11,6,
artist_array_type(artist_type('Miles Davis','Composer'),artist_type('Miles Davis','Musician')),
review_table_type(review_type('Sara','3-OCT-2016','Another Must Have! One of Miles finest works.',5),review_type('Douglas','14-JUN-2014','You might like it, but I admit it seems like a difficult listen.',5)),
'Audio CD',1,6.41,7.00));


/

insert into albums
values (disk_type('Gustav Mahler Symphony No. 9',45,'12-OCT-2017','Classical',23.10,5,
artist_array_type(artist_type('David Zinman','Conductor'),artist_type('Gustav Mahler','Composer'),artist_type('Tonhalle Orchestra','Orchestra')),
review_table_type(review_type('Lindon','3-DEC-2010','This is an uneventful but fine recording.',3),review_type('Prescott','24-AUG-2013','This is truly a spellbinding record.',5)),
'Audio CD',1,15.20,7.00 ));
/
insert into albums
values (mp3_type('Bob Dylans Greatest Hits',55,'1-JAN-2019','Pop Rock',5.98,10,
artist_array_type(artist_type('Bob Dylan','Composer'),artist_type('Bob Dylan','Vocals')),
review_table_type(review_type('Mandy','16-MAR-2019','Fantastic music!',5)),60
));
/
insert into albums
values (mp3_type('Best of Neil Young',153,'21-FEB-2019','Pop Rock',17.50,35,
artist_array_type(artist_type('Neil Young','Composer'),artist_type('Neil Young','Vocals')),
review_table_type(review_type('John','16-APR-2019','Great artist and great music.',5)),165
));
/
insert into albums
values (mp3_type('Harvest (2009 Remaster)',44,'21-JUN-2009','Rock Country',9.49,10,
artist_array_type(artist_type('Neil Young','Composer'),artist_type('Neil Young','Vocals')),
review_table_type(review_type('John','16-APR-2019','Great artist and great music.',5)),52
));
/
insert into albums
values (mp3_type('Sketches of Spain',45,'16-AUG-2013','Jazz',24.99,6,
artist_array_type(artist_type('Miles Davis','Composer'),artist_type('Miles Davis','Musician')),
review_table_type(review_type('Douglas','14-JUN-2014','You might like it but I admit it seems like a difficult listen.',5)),51
));
/
insert into albums
values (mp3_type('B.B. King Greatest Hits',114,'16-JUL-2013','Rock Blues',11.49,24,
artist_array_type(artist_type('B.B. King','Vocals'),artist_type('B.B. King','Guitar')),
review_table_type(review_type('David','18-MAY-2015','I highly recommend this album to anyone who want to see what BB King is all about.',4)),125
));
/
insert into albums
values (mp3_type('The Essential Bob Dylan',99,'8-JUL-2016','Pop',16.00,32,
artist_array_type(artist_type('Bob Dylan','Composer'),artist_type('Bob Dylan','Vocals')),
review_table_type(review_type('Christopher','24-JUN-2016','This is a terrific album.',5),review_type('Cauley','2-APR-2015','There can only be one Bob Dylan. God blessed him with the gift of verse',5)),112
));
/
insert into albums
values (mp3_type('Other Peoples Lives',42 ,'15-FEB-2019','Rock Dance',9.49,10,
artist_array_type(artist_type('Stats','Composer'),artist_type('Stats','Vocals')),
review_table_type(review_type('George','17-SEP-2019','Good dancing music.',3)),45
));

--1

select a.*
from Albums a, table(a.albumartists) b
where b.artistname =  'Neil Young' AND a.albumreleasedate > '01-Jan-2015';

--2
select distinct a.albumtitle,b.artistname
from albums a ,table(a.albumartists) b
where value(a) IS OF (mp3_type)
Order by a.albumtitle;

--3

select a.albumtitle, b.reviewscore
from albums a, table(a.albumreviews) b 
where value(a) is of (mp3_type)
group by a.albumtitle
having b.reviewscore = 


select min((avg(b.reviewscore)))
from albums a, table(a.albumreviews) b 
where value(a) is of (mp3_type)
group by a.albumtitle
having
count(b.reviewscore)!=1


--5

create or replace type body mp3_type as
overriding member function discountPrice return number is
discountedPrice number;
begin
if ((sysdate-albumReleaseDate)/365)>2 THEN
discountedPrice:=round((albumPrice-albumPrice*0.10),0);
END IF;

return discountedPrice;
end discountPrice;
end;

select *


create or replace type body disk_type as
overriding member function discountPrice return number is
discountedPrice number;
begin
if ((sysdate-albumReleaseDate)/365)>1 
and
mediatype='Vinyl'
THEN
discountedPrice:=round((albumPrice-albumPrice*0.15),0);
END IF;

return discountedPrice;
end discountPrice;
end;

create or replace type body disk_type as
overriding member function discountPrice return number is
discountedPrice number;
begin
if ((sysdate-albumReleaseDate)/365)>1 
and
mediatype='Audio CD'
THEN
discountedPrice:=round((albumPrice-albumPrice*0.20),0);
END IF;

return discountedPrice;
end discountPrice;
end;





drop view all_albums;    
create view all_albums (albumTitle, albumPrice,mediaType, discount) as
select a.albumTitle, a.albumPrice, 'MP3', a.albumprice-a.discountprice()
from albums a
where value(a) is of (mp3_type)
union
select  a.albumTitle,a.albumPrice,'Audio CD', a.albumprice-a.discountprice()
from albums a
where value(a) is of (disk_type)
and treat(value(a) as disk_type).mediatype='Audio CD'
union
select  a.albumTitle,albumPrice, 'Vinyl', a.albumprice-a.discountprice()
from albums a
where value(a) is of (disk_type)
and treat(value(a) as disk_type).mediatype='Vinyl'

select * from all_albums
where discount= (select max(discount) from all_albums)

alter view all_albums as
  select ,
         New_Col
  from albums a
  where value(a) is of (disk_type)

alter view all_albums as
  select a.*, treat(value(b) as disk_type).diskusedprice as diskUsedPrice
  from all_albums a, albums b
  group by a.albumtitle

  
 select treat(value(b) as disk_type).diskusedprice
  from albums b
   
  
  
drop view all_albums;    
create view all_albums (albumTitle, albumPrice,mediaType, discount, albumUsedPrice) as
select a.albumTitle, a.albumPrice, 'MP3', a.albumprice-a.discountprice(),0
from albums a
where value(a) is of (mp3_type)
union
select  a.albumTitle,a.albumPrice,'Audio CD', a.albumprice-a.discountprice(), treat(value(a) as disk_type).diskusedprice
from albums a
where value(a) is of (disk_type)
and treat(value(a) as disk_type).mediatype='Audio CD'
union
select  a.albumTitle,albumPrice, 'Vinyl', a.albumprice-a.discountprice(), treat(value(a) as disk_type).diskusedprice
from albums a
where value(a) is of (disk_type)
and treat(value(a) as disk_type).mediatype='Vinyl'
  
  select * from albums
  
  
  
create or replace type body review_type under album_type as
overriding member function containsText return number is
result_value number;
begin
if pString1 CONTAINS pstring2
THEN
result_value=1;
Else
result_value=0;
END IF;

return result_value;
end containsText;
end;
      