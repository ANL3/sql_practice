--Q1--Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

--Q2--Show who won the 1962 prize for literature.

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature'

--Q3--Show the year and subject that won 'Albert Einstein' his prize.

select yr, subject from nobel
where winner='Albert Einstein'

--Q4--Give the name of the 'peace' winners since the year 2000, including 2000.

select winner from nobel
where subject='peace' and yr>=2000

--Q5--Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.

select yr,subject,winner from nobel
where yr <= 1989 and yr >=1980 and subject='Literature'

--Q6--Show all details of the presidential winners:
--Theodore Roosevelt
--Thomas Woodrow Wilson
--Jimmy Carter
--Barack Obama

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter','Barack Obama')

--Q7--Show the winners with first name John

select winner from nobel where winner like 'John%'

--Q8--Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.

select yr,subject,winner from nobel
where (subject='Physics' and yr=1980) or (subject='Chemistry' and yr=1984)

--Q9--Show the year, subject, and name of winners for 1980 excluding chemistry and medicine

select yr,subject,winner from nobel where yr=1980 and subject not like 'Chemistry' and subject not like 'Medicine'

--Q10--Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

select yr,subject,winner from nobel where subject='Medicine' and yr<1910
union
select yr,subject,winner from nobel where subject='Literature' and yr>=2004

--Q11--Find all details of the prize won by PETER GRÜNBERG

select yr,subject,winner from nobel where winner like 'PETER GRÜNBERG'

--Q12--Find all details of the prize won by EUGENE O'NEILL

select yr,subject,winner from nobel where winner like 'EUGENE O%NEILL'

--Q13--Knights in order
--List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

select winner,yr,subject from nobel where winner like 'Sir%' order by yr desc,winner

--Q14--The expression subject IN ('chemistry','physics') can be used as a value - it will be 0 or 1.
--Show the 1984 winners and subject ordered by subject and winner name; but list chemistry and physics last.

SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner

