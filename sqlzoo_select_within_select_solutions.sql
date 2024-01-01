--Q1--List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--Q2--Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name FROM world
where continent="Europe" and 
gdp/population > (SELECT gdp/population FROM world where name="United Kingdom")

--Q3--List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

select name, continent from world where 
continent = (select continent from world where name="Argentina") or 
continent = (select continent from world where name="Australia")

--Q4--Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

select name, population from world where 
population > (select population from world where name="United Kingdom") and 
population < (select population from world where name="Germany")

--Q5--Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany. Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

select name, 
concat(cast(round(population/(select population from world where name="Germany")*100,0) as char),"%") as percentage 
from world where continent="Europe"

--Q6--Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

select name from world where gdp > (select max(gdp) from world where continent="Europe")

--Q7--Find the largest country (by area) in each continent, show the continent, the name and the area: The above example is known as a correlated or synchronized sub-query.

SELECT continent, name, area FROM world x
  WHERE area >= ALL(SELECT area FROM world y
        WHERE y.continent=x.continent and population > 0)

--Q8--List each continent and the name of the country that comes first alphabetically.

SELECT continent, name FROM world x
  WHERE name <= ALL(SELECT name FROM world y
        WHERE y.continent=x.continent and population > 0)

--Q9--