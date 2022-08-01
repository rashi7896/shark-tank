select * from project..data1

-- total episodes

select max(epno) from project..data1
select count(distinct epno) from project..data1

-- pitches 

select count(distinct brand) from project..data1

--pitches converted

select cast(sum(a.converted_not_converted) as float) /cast(count(*) as float) from (
select amountinvestedlakhs , case when amountinvestedlakhs>0 then 1 else 0 end as converted_not_converted from project..data) a

-- total male

select sum(male) from project..data1

-- total female

select sum(female) from project..data1

--gender ratio

select sum(female)/sum(male) from project..data1

-- total invested amount

select sum(amountinvestedlakhs) from project..data1

-- avg equity taken

select avg(a.equitytakenp) from
(select * from project..data1 where equitytakenp>0) a

--highest deal taken

select max(amountinvestedlakhs) from project..data1 

--higheest equity taken

select max(equitytaken) from project..data1


-- pitches converted having atleast ne women

select * from project..data1


select sum(b.female_count) from(

select case when a.female>0 then 1 else 0 end as female_count ,a.*from (
(select * from project..data1 where deal!='No Deal')) a)b

-- avg team members

select avg(teammembers) from project..data1

-- amount invested per deal

select avg(a.amountinvestedlakhs) amount_invested_per_deal from
(select * from project..data1 where deal!='No Deal') a

-- avg age group of contestants

select avgage,count(avgage) cnt from project..data1 group by avgage order by cnt desc

-- location group of contestants

select location,count(location) cnt from project..data1 group by location order by cnt desc

-- sector group of contestants

select sector,count(sector) cnt from project..data1 group by sector order by cnt desc


--partner deals

select partners,count(partners) cnt from project..data1  where partners!='-' group by partners order by cnt desc

-- making the matrix


select * from project..data1

select 'Ashnner' as keyy,count(ashneeramountinvested) from project..data1 where ashneeramountinvested is not null


select 'Ashnner' as keyy,count(ashneeramountinvested) from project..data1 where ashneeramountinvested is not null AND ashneeramountinvested!=0

SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED),AVG(C.ASHNEEREQUITYTAKEN) 
FROM (SELECT * FROM PROJECT..DATA1  WHERE ASHNEEREQUITYTAKEN!=0 AND ASHNEEREQUITYTAKEN IS NOT NULL) C


select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals_present from project..data1 where ashneeramountinvested is not null) a

inner join (
select 'Ashneer' as keyy,count(ashneeramountinvested) total_deals from project..data1
where ashneeramountinvested is not null AND ashneeramountinvested!=0) b 

on a.keyy=b.keyy) m

inner join 

(SELECT 'Ashneer' as keyy,SUM(C.ASHNEERAMOUNTINVESTED) total_amount_invested,
AVG(C.ASHNEEREQUITYTAKEN) avg_equity_taken
FROM (SELECT * FROM PROJECT..DATA1  WHERE ASHNEEREQUITYTAKEN!=0 AND ASHNEEREQUITYTAKEN IS NOT NULL) C) n

on m.keyy=n.keyy

-- which is the startup in which the highest amount has been invested in each domain/sector




select c.* from 
(select brand,sector,amountinvestedlakhs,rank() over(partition by sector order by amountinvestedlakhs desc) rnk 

from project..data1) c

where c.rnk=1